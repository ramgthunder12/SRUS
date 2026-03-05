# SRUS 프로젝트 예외처리 정리

## 목차
1. [개요](#1-개요)
2. [Controller 계층 예외처리 (try-catch)](#2-controller-계층-예외처리-try-catch)
3. [Service 계층 예외 전파 (throws Exception)](#3-service-계층-예외-전파-throws-exception)
4. [Validator를 통한 입력 검증](#4-validator를-통한-입력-검증)
5. [Interceptor를 통한 접근 제어](#5-interceptor를-통한-접근-제어)
6. [HTTP 에러 처리 (CustomErrorController)](#6-http-에러-처리-customerrorcontroller)
7. [리소스 관리 예외처리 (try-catch-finally)](#7-리소스-관리-예외처리-try-catch-finally)
8. [예외처리 요약 통계](#8-예외처리-요약-통계)

---

## 1. 개요

SRUS(Space Rental Unmanned System) 프로젝트에서는 다음과 같은 방식으로 예외를 처리하고 있습니다:

| 처리 방식 | 위치 | 설명 |
|-----------|------|------|
| `try-catch` | Controller, Service | 비즈니스 로직 실행 시 발생하는 예외를 포착 |
| `throws Exception` | Service, Mapper | 예외를 상위 호출자에게 전파 |
| `Validator` | Controller (via `@InitBinder`) | 사용자 입력값 사전 검증 |
| `Interceptor` | 요청 전처리 | 세션/권한/경로 검증 |
| `CustomErrorController` | 전역 에러 처리 | HTTP 상태 코드 기반 에러 페이지 분기 |
| `try-catch-finally` | PaymentServiceImpl | 외부 API 호출 시 리소스 해제 보장 |

> **참고:** 모든 catch 블록에서 `e.printStackTrace()`를 사용하며, 별도의 로깅 프레임워크(SLF4J, Log4j 등)나 커스텀 예외 클래스는 사용하지 않습니다.

---

## 2. Controller 계층 예외처리 (try-catch)

모든 Controller의 핵심 메서드에서 `try-catch(Exception e)` 패턴을 사용하여 예외를 처리합니다.

### 2.1 MemberController (`/member`)

| 메서드 | HTTP 매핑 | 예외 발생 시나리오 | 처리 방식 |
|--------|-----------|-------------------|-----------|
| `comparePhoneNumber()` | `GET /member/phone` | 핸드폰 번호 대조 시 DB 조회 오류 | `e.printStackTrace()` |
| `findId()` | `POST /member/findid` | 이메일 필드 검증 실패 또는 ID 조회 오류 | `e.printStackTrace()` |
| `findPassword()` | `POST /member/findpassword` | ID/이메일 검증 실패 또는 비밀번호 조회 오류 | `e.printStackTrace()` |
| `signUp()` | `POST /member` | 회원가입 필드 검증 실패(id, password, email, phoneNumber) 또는 등록 오류 | `e.printStackTrace()` |
| `searchMyInfo()` | `GET /member/{id}` | 회원 정보 조회 오류 | `e.printStackTrace()` |
| `withdrawalMember()` | `DELETE /member/{id}` | 탈퇴 처리(탈퇴일 설정) 시 DB 업데이트 오류 | `e.printStackTrace()` |
| `modifyMemberForm()` | `GET /member/{id}/form` | 수정 폼용 회원 정보 조회 오류 | `e.printStackTrace()` |
| `modifyMember()` | `PUT /member/{id}` | 이메일/전화번호 검증 실패 또는 회원 정보 수정 오류 | `e.printStackTrace()` |
| `modifyCardInfo()` | `PUT /member/card` | 카드 UUID 정보 수정 오류 | `e.printStackTrace()` |
| `memberList()` | `GET /member` | 사용자 목록 조회 오류 | `e.printStackTrace()` |
| `searchMember()` | `GET /member` (JSON) | 사용자 검색 오류 | `e.printStackTrace()` |
| `idCheck()` | `GET /member/idcheck` (JSON) | 아이디 중복 검사 오류 | `e.printStackTrace()` |

### 2.2 RentalController (`/rental`)

| 메서드 | HTTP 매핑 | 예외 발생 시나리오 | 처리 방식 |
|--------|-----------|-------------------|-----------|
| `chooseRentalBox()` | `GET /rental/step1` | 무인대여함 목록 조회 오류 | `e.printStackTrace()` |
| `chooseRentalPeriod()` | `GET /rental/step2/{no}` | 대여함 존재 여부 확인 및 대여 불가능 날짜 조회 오류 | `e.printStackTrace()` |
| `registerRental()` | `POST /rental` | 대여 정보 등록 오류 | `e.printStackTrace()` |
| `memberRentalList()` | `GET /rental/{id}` | 회원 대여 내역 조회 오류 | `e.printStackTrace()` |
| `adminRentalList()` | `GET /rental` | 관리자 대여 목록 조회 오류 | `e.printStackTrace()` |
| `searchRental()` | `GET /rental` (JSON) | 대여 정보 검색 오류 | `e.printStackTrace()` |
| `searchCurrentRental()` | `GET /rental/{id}/current` | 현재 대여 정보 조회 오류 | `e.printStackTrace()` |

### 2.3 RentalBoxController (`/rentalbox`)

| 메서드 | HTTP 매핑 | 예외 발생 시나리오 | 처리 방식 |
|--------|-----------|-------------------|-----------|
| `rentalBoxList()` | `GET /rentalbox` | 무인대여함 목록 조회 오류 | `e.printStackTrace()` |
| `registerRentalBox()` | `POST /rentalbox` | 입력 검증 실패 시 에러 메시지 표시, 등록 오류 | `e.printStackTrace()` |
| `modifyRentalBoxForm()` | `GET /rentalbox/{no}/form` | 수정 폼용 대여함 정보 조회 오류 | `e.printStackTrace()` |
| `modifyRentalBox()` | `PUT /rentalbox/{no}` | 입력 검증 실패 시 에러 메시지 표시, 수정 오류 | `e.printStackTrace()` |

### 2.4 PaymentController (`/payment`)

| 메서드 | HTTP 매핑 | 예외 발생 시나리오 | 처리 방식 |
|--------|-----------|-------------------|-----------|
| `confirmForm()` | `GET /payment/confirmationform` | 대여 날짜 검증, 대여함 존재 확인, 결제 금액 계산 오류 | `e.printStackTrace()` |
| `cancelPayment()` | `GET /payment/cancel` | 아임포트 토큰 획득 또는 결제 취소 API 호출 오류 | `e.printStackTrace()` |

### 2.5 AuthenticationController (`/authentication`)

| 메서드 | HTTP 매핑 | 예외 발생 시나리오 | 처리 방식 |
|--------|-----------|-------------------|-----------|
| `grantAuthInfo()` | `GET /authentication/grantauthinfo` | 인증키 부여 처리 오류 | `e.printStackTrace()` |
| `compareCardUID()` | `GET /authentication/comparecarduid` | 카드 UID 대조 오류 | `e.printStackTrace()` |

### 2.6 UsageHistoryController (`/usagehistory`)

| 메서드 | HTTP 매핑 | 예외 발생 시나리오 | 처리 방식 |
|--------|-----------|-------------------|-----------|
| `memberUsageHistoryList()` | `GET /usagehistory/{id}` | 회원 이용내역 조회 오류 | `e.printStackTrace()` |
| `adminUsageHistoryList()` | `GET /usagehistory` | 관리자 이용내역 조회 오류 | `e.printStackTrace()` |
| `searchUsageHistory()` | `GET /usagehistory` (JSON) | 이용내역 검색 오류 | `e.printStackTrace()` |
| `registerUsageHistory()` | `POST /usagehistory` | 이용내역 등록 오류 | `e.printStackTrace()` |

### 2.7 CommonController (`/`)

| 메서드 | HTTP 매핑 | 예외 발생 시나리오 | 처리 방식 |
|--------|-----------|-------------------|-----------|
| `login()` | `POST /login` | ID/비밀번호 검증 실패, 로그인 처리 오류, "가입하지 않은 아이디이거나, 잘못된 비밀번호입니다." 메시지 표시 | `e.printStackTrace()` |
| `validMember()` | `POST /validmember` | 회원 검증(존재 여부 + 구분값 확인) 오류 | `e.printStackTrace()` |

---

## 3. Service 계층 예외 전파 (throws Exception)

Service 계층의 모든 메서드는 `throws Exception`을 선언하여 예외를 Controller로 전파합니다.

### 3.1 MemberService / MemberServiceImpl

| 메서드 | 기능 | 예외 전파 |
|--------|------|-----------|
| `comparePhoneNumber(Member)` | 핸드폰 번호 대조 | `throws Exception` |
| `findId(Member)` | 아이디 찾기 | `throws Exception` |
| `findPassword(Member)` | 비밀번호 찾기 | `throws Exception` |
| `registerMemberInfo(Member)` | 회원 등록 | `throws Exception` |
| `searchMemberInfoList(Member)` | 회원 목록 조회 | `throws Exception` |
| `searchMemberInfo(Member)` | 회원 정보 조회 | `throws Exception` |
| `modifyMemberInfo(Member)` | 회원 정보 수정 | `throws Exception` |
| `cardMemberInfo(Member)` | 카드 정보 수정 | `throws Exception` |

### 3.2 RentalService / RentalServiceImpl

| 메서드 | 기능 | 예외 전파 |
|--------|------|-----------|
| `searchUnrentableDate(RentalBox)` | 대여 불가능 날짜 조회 | `throws Exception` |
| `registerRentalInfo(Rental)` | 대여 정보 등록 | `throws Exception` |
| `searchRentalInfoList(Rental)` | 대여 정보 목록 조회 | `throws Exception` |
| `searchRentalInfo(Rental)` | 대여 정보 검색 | `throws Exception` |
| `modifyRentalInfo(Rental)` | 대여 정보 수정 | `throws Exception` |
| `calculatePayment(Rental)` | 결제 금액 계산 | `throws Exception` |
| `searchCurrentRental(Member)` | 현재 대여 정보 조회 | `throws Exception` |

### 3.3 RentalBoxService / RentalBoxServiceImpl

| 메서드 | 기능 | 예외 전파 |
|--------|------|-----------|
| `registerRentalBoxInfo(RentalBox)` | 대여함 등록 | `throws Exception` |
| `searchRentalBoxInfoList(RentalBox)` | 대여함 목록 조회 | `throws Exception` |
| `searchRentalBoxInfo(RentalBox)` | 대여함 정보 조회 | `throws Exception` |
| `modifyRentalBoxInfo(RentalBox)` | 대여함 정보 수정 | `throws Exception` |

### 3.4 AuthenticationService / AuthenticationServiceImpl

| 메서드 | 기능 | 예외 전파 |
|--------|------|-----------|
| `grantAuthInfo(Member, RentalBox)` | 인증키 부여 | `throws Exception` |
| `compareCardUID(RentalBox)` | 카드 UID 대조 | `throws Exception` |

### 3.5 UsageHistoryService / UsageHistoryServiceImpl

| 메서드 | 기능 | 예외 전파 |
|--------|------|-----------|
| `registerUsageHistory(UsageHistory)` | 이용내역 등록 | `throws Exception` |
| `searchUsageHistoryList(UsageHistory)` | 이용내역 목록 조회 | `throws Exception` |

### 3.6 CommonService / CommonServiceImpl

| 메서드 | 기능 | 예외 전파 |
|--------|------|-----------|
| `login(Member)` | 로그인 처리 | `throws Exception` |

### 3.7 PaymentService / PaymentServiceImpl

| 메서드 | 기능 | 예외 전파 |
|--------|------|-----------|
| `getToken(String)` | 아임포트 API 토큰 획득 | `throws Exception` |
| `cancelPayment(Rental, String)` | 결제 취소 (내부 try-catch 사용) | 자체 처리 |

---

## 4. Validator를 통한 입력 검증

Spring의 `Validator` 인터페이스를 구현하여 사용자 입력값을 사전 검증합니다. 검증 실패 시 `Errors` 객체에 오류를 추가하여 Controller에서 처리합니다.

### 4.1 MemberValidator

**적용 대상:** `MemberController`, `CommonController` (`@InitBinder`로 등록)

| 검증 필드 | 검증 조건 | 오류 코드 |
|-----------|-----------|-----------|
| `id` | 빈 값 또는 공백 | `required` |
| `password` | 빈 값 또는 공백 | `required` |
| `email` | 빈 값 또는 공백 | `required` |
| `phoneNumber` | 빈 값 또는 공백 | `required` |

**Controller에서의 검증 활용:**
- `signUp()`: id, password, email, phoneNumber 모두 검증
- `findId()`: email 필드만 검증
- `findPassword()`: id, email 필드 검증
- `modifyMember()`: email, phoneNumber 필드 검증
- `login()`: id, password 필드 검증

### 4.2 RentalBoxValidator

**적용 대상:** `RentalBoxController` (`@InitBinder`로 등록)

| 검증 필드 | 검증 조건 | 오류 코드 |
|-----------|-----------|-----------|
| `model` | 빈 값 또는 공백 | `required` |
| `location` | 빈 값 또는 공백 | `required` |
| `size` | 빈 값 또는 공백 | `required` |
| `charge` | 빈 값 또는 공백 | `required` |

**Controller에서의 검증 활용:**
- `registerRentalBox()`: 전체 필드 검증 → 실패 시 "입력란에 모든 항목을 형식에 맞게 제대로 입력해주세요." 메시지
- `modifyRentalBox()`: 전체 필드 검증 → 실패 시 동일한 에러 메시지

### 4.3 RentalDateValidator

**적용 대상:** `PaymentController.confirmForm()`에서 수동 호출

| 검증 필드 | 검증 조건 | 오류 코드 |
|-----------|-----------|-----------|
| `rentalBoxNo` | 빈 값 또는 공백 | `required` |
| `startDate` | null 값 | `required` |
| `startDate` | 현재 날짜 이전이거나 종료일 이후 | `invalid` |
| `endDate` | null 값 | `required` |
| `endDate` | 현재 날짜 이전이거나 시작일 이전 | `invalid` |

**Controller에서의 검증 활용:**
- `confirmForm()`: 대여함 번호 + 날짜 검증 → 실패 시 적절한 화면으로 리다이렉트

---

## 5. Interceptor를 통한 접근 제어

Spring `HandlerInterceptor`를 구현하여 요청 전처리 단계에서 접근 제어를 수행합니다.

### 5.1 LoginInterceptor

| 항목 | 내용 |
|------|------|
| **throws 선언** | `throws IOException` |
| **적용 경로** | `/login` |
| **동작** | 이미 로그인된 사용자가 `/login`에 접근하면 `/main`으로 리다이렉트 |

### 5.2 SessionCheckInterceptor

| 항목 | 내용 |
|------|------|
| **throws 선언** | `throws Exception` |
| **적용 경로** | 세션 필요 경로 전체 |
| **동작** | 세션에 `member` 속성이 없으면 `/login`으로 리다이렉트. 단, `POST /member`(회원가입)와 `POST /usagehistory`(이용내역 등록)는 예외적으로 허용 |

### 5.3 AuthCheckInterceptor

| 항목 | 내용 |
|------|------|
| **throws 선언** | `throws Exception` |
| **적용 경로** | 관리자 전용 경로 |
| **동작** | 관리자(`division == 'A'`)가 아닌 사용자의 접근을 `/main`으로 리다이렉트. `POST /member`, `POST /usagehistory`, `POST /rental`은 예외적으로 허용 |

### 5.4 PathVariableInterceptor

| 항목 | 내용 |
|------|------|
| **throws 선언** | `throws IOException` |
| **적용 경로** | PathVariable이 포함된 회원 전용 경로 |
| **동작** | URL 경로에 포함된 ID가 세션의 회원 ID와 일치하는지 확인. 불일치 시 `/main`으로 리다이렉트 |

---

## 6. HTTP 에러 처리 (CustomErrorController)

`ErrorController` 인터페이스를 구현하여 HTTP 상태 코드에 따른 에러 페이지를 제공합니다.

```java
// CustomErrorController.java
@RequestMapping("/error")
public ModelAndView handleError(HttpServletRequest request) {
    Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

    if (status != null) {
        int statusCode = Integer.valueOf(status.toString());
        if (statusCode == HttpStatus.NOT_FOUND.value()) {       // 404
            mav = new ModelAndView("/errors/404");
        }
        if (statusCode == HttpStatus.FORBIDDEN.value()) {       // 403
            mav = new ModelAndView("/errors/500");
        }
    }
    return mav;
}
```

| HTTP 상태 코드 | 에러 페이지 | 설명 |
|----------------|------------|------|
| 404 (Not Found) | `/errors/404` | 요청한 페이지를 찾을 수 없을 때 |
| 403 (Forbidden) | `/errors/500` | 접근 권한이 없을 때 (500 페이지로 연결) |

---

## 7. 리소스 관리 예외처리 (try-catch-finally)

`PaymentServiceImpl.cancelPayment()` 메서드에서는 외부 API(아임포트)와의 HTTP 통신 시 `try-catch-finally` 패턴을 사용하여 리소스 해제를 보장합니다.

```java
// PaymentServiceImpl.java - cancelPayment()
try {
    // 1. DB에서 대여 정보 조회
    // 2. 아임포트 API로 결제 취소 요청 (HttpURLConnection)
    // 3. 취소일 업데이트
} catch (Exception e) {
    e.printStackTrace();
} finally {
    try {
        if (bufferedReader != null) {
            bufferedReader.close();          // BufferedReader 해제
        }
        if (connection != null) {
            connection.disconnect();         // HttpURLConnection 해제
        }
    } catch (Exception e) {
        e.printStackTrace();                 // 리소스 해제 중 오류도 처리
    }
}
```

**특징:**
- 프로젝트 내 유일한 `try-catch-finally` 패턴
- 중첩 try-catch: `finally` 블록 내부에도 별도의 try-catch 사용
- `BufferedReader`와 `HttpURLConnection` 리소스를 안전하게 해제

---

## 8. 예외처리 요약 통계

| 항목 | 수량 |
|------|------|
| **try-catch 블록** (Controller) | 29개 |
| **throws Exception 메서드** (Service) | 22개 |
| **Validator 클래스** | 3개 (MemberValidator, RentalBoxValidator, RentalDateValidator) |
| **Interceptor 클래스** | 4개 (Login, SessionCheck, AuthCheck, PathVariable) |
| **ErrorController** | 1개 (CustomErrorController) |
| **try-catch-finally** (중첩) | 1개 (PaymentServiceImpl.cancelPayment) |
| **커스텀 예외 클래스** | 0개 |
| **로깅 프레임워크 사용** | 없음 (`e.printStackTrace()` 만 사용) |

### 예외처리 흐름도

```
[사용자 요청]
    │
    ▼
[Interceptor] ── 세션/권한/경로 검증 실패 ──→ 리다이렉트 (/login 또는 /main)
    │
    ▼ (통과)
[Controller]
    │
    ├── [Validator] ── 입력 검증 실패 ──→ 에러 메시지와 함께 폼 재표시
    │
    └── try {
            [Service] ── throws Exception ──→ [Mapper/DB]
        } catch (Exception e) {
            e.printStackTrace();  ──→ 콘솔 출력
        }
    │
    ▼
[CustomErrorController] ── 404/403 ──→ 에러 페이지 표시
```
