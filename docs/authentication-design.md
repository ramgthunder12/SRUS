# 인증 로직 설계 문서

## 목차

1. [전체 인증 구조 개요](#1-전체-인증-구조-개요)
2. [웹 로그인 / 세션 인증](#2-웹-로그인--세션-인증)
3. [인터셉터 체인 및 경로 보호](#3-인터셉터-체인-및-경로-보호)
4. [NFC 카드 물리 인증 (무인대여함)](#4-nfc-카드-물리-인증-무인대여함)
5. [회원 권한 구분 (division)](#5-회원-권한-구분-division)
6. [컴포넌트 의존 관계](#6-컴포넌트-의존-관계)

---

## 1. 전체 인증 구조 개요

SRUS의 인증은 **두 가지 독립적인 흐름**으로 구성됩니다.

```
┌─────────────────────────────────────────────────────────┐
│  ① 웹 로그인 / 세션 인증                                  │
│     브라우저 ──POST /login──> CommonController           │
│                               └─> session["member"] 저장 │
│     이후 모든 요청 ──> 인터셉터 체인으로 접근 제어           │
├─────────────────────────────────────────────────────────┤
│  ② NFC 카드 물리 인증 (무인대여함)                          │
│     인증데스크(ADS) ──GET /authentication/grantauthinfo  │
│                         └─> rental_box.AUTH_KEY 기록     │
│     무인대여함(RBS)  ──GET /authentication/comparecarduid │
│                         └─> AUTH_KEY 대조 및 유효기간 검증 │
└─────────────────────────────────────────────────────────┘
```

---

## 2. 웹 로그인 / 세션 인증

### 2.1 관련 클래스

| 클래스 | 역할 |
|---|---|
| `CommonController` | 로그인·로그아웃·회원 검증 HTTP 엔드포인트 |
| `CommonServiceImpl` | DB 조회를 통한 로그인 여부 판별, 세션 무효화 |
| `MemberValidator` | `@Valid` 기반 입력값(ID·비밀번호) 형식 검증 |

### 2.2 로그인 흐름

```
POST /login
  │
  ├─ MemberValidator (@InitBinder)
  │    ├─ id / password 빈 값 또는 형식 오류 → 로그인 폼 재표시 + 오류 메시지
  │
  ├─ CommonServiceImpl.login(member)
  │    └─ MemberMapper.select(member)
  │         SQL: WHERE ID = BINARY #{id} AND PASSWORD = BINARY #{password}
  │         ※ BINARY 키워드 → 대소문자·바이트 단위 정확 일치
  │    └─ row != null && row.getWithdrawalDate() == null  (탈퇴하지 않은 회원)
  │         → isLogin = true
  │
  ├─ 로그인 성공 시
  │    MemberServiceImpl.searchMemberInfo(member)
  │         → member.division 값(M/A) 조회
  │    session.setAttribute("member", member)
  │         ※ Member 객체에 id + division 만 세션에 저장
  │    redirect:/main
  │
  └─ 로그인 실패 시 → 로그인 폼 재표시 + 오류 메시지
```

### 2.3 로그아웃

```
GET /logout
  └─ CommonServiceImpl.logout()
       └─ session.invalidate()   (세션 전체 무효화)
  └─ redirect:/main
```

### 2.4 회원 재검증 (`/validmember`)

결제 단계 등에서 현재 로그인 사용자가 일반 회원(`division == 'M'`)임을 재확인하는 엔드포인트입니다.

```
POST /validmember
  │
  ├─ MemberServiceImpl.searchMemberInfo(member) → row
  │    row.getDivision() == 'M' 인 경우에만
  │
  └─ CommonServiceImpl.login(member) → 비밀번호까지 재확인
       → { "result": true/false }
```

---

## 3. 인터셉터 체인 및 경로 보호

`WebMvcConfig`에서 4개의 인터셉터를 순서대로 등록합니다.

### 3.1 인터셉터 실행 순서

```
요청 진입
  │
  ▼
① LoginInterceptor
  │  (경로: /login)
  │  이미 로그인된 사용자가 /login 접근 → redirect:/main
  │
  ▼
② SessionCheckInterceptor
  │  (경로: /member/*, /payment/*, /rental/*, /rentalbox/*, /usagehistory/*)
  │  세션에 member 없음 → redirect:/login
  │  예외: POST /member (회원 가입), POST /usagehistory (외부 시스템 알림)
  │
  ▼
③ AuthCheckInterceptor
  │  (경로: /member, /rentalbox/*, /rental, /rental/admin, /usagehistory/admin, /usagehistory)
  │  session["member"].division != 'A' → redirect:/main
  │  예외: POST /member, POST /usagehistory, POST /rental (일반 회원 허용 작업)
  │
  ▼
④ PathVariableInterceptor
  │  (경로: /member/{id}/*, /usagehistory/{memberId}/*, /rental/{id}/*)
  │  URL 경로 토큰 중 session["member"].id 와 일치하는 값이 없으면 → redirect:/main
  │  ※ 타인 데이터 접근 차단 (IDOR 방어)
  │
  ▼
Controller
```

### 3.2 경로별 접근 제어 요약표

| 경로 패턴 | LoginInterceptor | SessionCheck | AuthCheck | PathVariable |
|---|:---:|:---:|:---:|:---:|
| `/login` | ✅ | | | |
| `/member` (POST) | | 허용 예외 | 허용 예외 | |
| `/member/{id}` | | ✅ | | ✅ |
| `/member/{id}/form` | | ✅ | | ✅ |
| `/member` (관리자) | | ✅ | ✅ | |
| `/rentalbox/*` | | ✅ | ✅ | |
| `/rental` | | ✅ | ✅ | |
| `/rental/{id}/*` | | ✅ | | ✅ |
| `/rental/*/current` | | | | |
| `/payment/*` | | ✅ | | |
| `/usagehistory` (POST) | | 허용 예외 | 허용 예외 | |
| `/usagehistory/{id}` | | ✅ | | ✅ |
| `/usagehistory/admin` | | ✅ | ✅ | |

### 3.3 PathVariableInterceptor 동작 원리

```java
// URL 경로를 "/" 기준으로 토큰 분리
StringTokenizer st = new StringTokenizer(requestURL, "/");
while (st.hasMoreTokens()) {
    if (token.equals(memberId)) return true;   // 일치하는 토큰 발견 시 허용
}
return false;  // 없으면 차단 → redirect:/main
```

예시: `/member/john123/form` 요청 시, 세션 ID가 `john123` 이면 허용, 다른 값이면 차단.

---

## 4. NFC 카드 물리 인증 (무인대여함)

### 4.1 관련 클래스

| 클래스 | 역할 |
|---|---|
| `AuthenticationController` | REST API 엔드포인트 (`/authentication/*`) |
| `AuthenticationServiceImpl` | 인증키 부여 및 카드 UID 대조 비즈니스 로직 |
| `MemberMapper` | 회원 카드 UUID 조회 |
| `RentalBoxMapper` | rental_box 테이블의 AUTH_KEY·AUTH_ISSUE_DATE 읽기/쓰기 |

### 4.2 전체 흐름

```
[카드 등록 단계 – 인증데스크(ADS) 주도]

사용자가 인증데스크 NFC 리더기에 카드 태그
  │
  ADS: MemberRepository → POST {memberId, cardUid} → member.CARD_UID 갱신
  ※ 이 단계는 ADS 서버 내부에서 처리됨


[인증키 부여 단계 – ADS → SRUS]

ADS GET /authentication/grantauthinfo?id={memberId}&no={rentalBoxNo}
  │
  AuthenticationServiceImpl.grantAuthInfo(member, rentalBox)
  │  └─ MemberMapper.select(member) → row.cardUid 조회
  │  └─ cardUid != null && !empty 검증
  │  └─ rentalBox.authKey   = row.cardUid
  │     rentalBox.authIssueDate = LocalDateTime.now()   ← 발급 시각 기록
  │  └─ RentalBoxMapper.update(rentalBox)
  │       UPDATE rental_box SET AUTH_KEY=?, AUTH_ISSUE_DATE=? WHERE NO=?
  │
  └─ 응답: { "result": true/false }


[카드 UID 대조 단계 – RBS → SRUS]

무인대여함(RBS)에서 카드 태그 감지
  │
  RBS GET /authentication/comparecarduid?no={rentalBoxNo}&authKey={scannedUID}
  │
  AuthenticationServiceImpl.compareCardUID(rentalBox)
  │  └─ RentalBoxMapper.select(rentalBox)
  │       WHERE NO=? AND AUTH_KEY=?   ← 번호 + 키 동시 조회
  │
  │  └─ row != null && row.authKey != null  (인증키가 DB에 존재)
  │
  │  ├─ authIssueDate + 1분 < 현재시각  → 만료
  │  │    rentalBox.authKey        = null
  │  │    rentalBox.authIssueDate  = null
  │  │    RentalBoxMapper.updateAuth(rentalBox)   ← AUTH_KEY/DATE 클리어
  │  │    isMatched = false
  │  │
  │  └─ 유효기간 내 → isMatched = true
  │
  └─ 응답: { "result": true/false }
      true  → RBS가 모터 구동, 무인대여함 개방
      false → 인증 실패 또는 만료
```

### 4.3 인증키 유효기간 (1분)

```java
// AuthenticationServiceImpl.compareCardUID()
LocalDateTime authIssueDate = row.getAuthIssueDate().plusMinutes(1);

if (LocalDateTime.now().isAfter(authIssueDate)) {
    // 만료: AUTH_KEY / AUTH_ISSUE_DATE 클리어
} else {
    isMatched = true;
}
```

인증키는 발급 후 **1분** 동안만 유효합니다.  
1분이 지나면 DB에서 키를 자동 삭제하므로, 같은 키로 재인증이 불가능합니다.

### 4.4 DB 스키마 (인증 관련 컬럼)

**member 테이블**

| 컬럼 | 타입 | 설명 |
|---|---|---|
| `CARD_UID` | VARCHAR | NFC 카드 고유 UID (인증데스크에서 등록) |

**rental_box 테이블**

| 컬럼 | 타입 | 설명 |
|---|---|---|
| `AUTH_KEY` | VARCHAR | 현재 발급된 인증키 (= 회원 CARD_UID 복사본) |
| `AUTH_ISSUE_DATE` | DATETIME | 인증키 발급 시각 (유효기간 계산 기준) |

---

## 5. 회원 권한 구분 (division)

| 값 | 역할 | 접근 가능 기능 |
|---|---|---|
| `'M'` | 일반 회원 | 회원 정보 관리, 대여·결제, 이용 내역 조회 |
| `'A'` | 관리자 | 위 모든 기능 + 대여함 관리, 회원 목록 조회, 이용 내역 전체 조회 |

- 로그인 성공 직후 `MemberServiceImpl.searchMemberInfo()`로 `division` 값을 조회하여 세션의 `Member` 객체에 설정합니다.
- `AuthCheckInterceptor`는 `member.getDivision() == 'A'` 여부만 확인하므로, 세션에 `division`이 정확히 설정되어 있어야 합니다.

---

## 6. 컴포넌트 의존 관계

```
                    ┌──────────────────────────────────────┐
                    │          WebMvcConfig                 │
                    │  (인터셉터 4개 등록 및 경로 매핑)        │
                    └──────────┬───────────────────────────┘
                               │ 등록
        ┌──────────────────────┼────────────────────────────┐
        ▼                      ▼                            ▼
LoginInterceptor   SessionCheckInterceptor        AuthCheckInterceptor
(로그인 중복 방지)   (세션 존재 여부 확인)           (관리자 권한 확인)
                                                  PathVariableInterceptor
                                                  (URL 소유자 확인)

    ┌──────────────────┐         ┌────────────────────────┐
    │  CommonController │         │ AuthenticationController│
    │  /login, /logout  │         │ /authentication/*       │
    └────────┬─────────┘         └──────────┬─────────────┘
             │                              │
    CommonServiceImpl               AuthenticationServiceImpl
             │                        ┌────┴────────────┐
    MemberMapper                 MemberMapper    RentalBoxMapper
    (DB: member)                 (CARD_UID)      (AUTH_KEY, AUTH_ISSUE_DATE)
```
