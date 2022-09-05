
## 1. 제작 기간 & 참여 인원
- 2020년 10월 ~ 2020년 12월
- 팀 프로젝트

</br>

## 2. 인증데스크 시스템 및 무인대여함 시스템
#### 인증 데스크 시스템
* https://github.com/SpaceRentalUnmannedSystem/ADS

#### 무인 대여함 시스템
* https://github.com/SpaceRentalUnmannedSystem/RBS

</br>

## 3. 사용 기술
#### `Back-end`
  - Java 11
  - Servlet
  - Jsp
  - Spring Boot 2.4
  - Mybatis
  - Maven
  - MySQL
#### `Front-end`
  - HTML
  - JavaScript
  - CSS
  - JQuery

</br>

## 4. 핵심 기능
이 서비스의 핵심 기능은 무인 대여함 주문 및 결제, 카드 NFC를 이용한 인증입니다.  
사용자는 자신이 사용하고 싶은 무인 대여함을 주문하고 결제할 수 있고,
이 후에 카드를 이용해 무인 대여함을 이용할 수 있습니다.

아래는 핵심 기능 설명입니다.

<details>
<summary><b>4.1 카드 인증 핵심 설명 펼치기</b></summary>
<div markdown="1">

### 4.1.1 카드 인증 전체 흐름
![image](https://user-images.githubusercontent.com/63217462/145766832-d55d0bee-2fe1-4c86-b08f-b3fc9e6e38bb.png)

### 4.1.2 사용자 요청
![image](https://user-images.githubusercontent.com/63217462/145767707-43334b5b-c824-4ac7-9a03-a3e14e044248.png)

  
![image](https://user-images.githubusercontent.com/63217462/145767091-594889f2-02bd-4dd5-9ad2-d65d861aade7.png)

- **사용자의 카드 등록** 
  - 처음 사용하는 사용자는 인증 데스크에서 카드를 등록을 합니다.
  - 카드 등록 시 카드 UUID를 데이터베이스에 저장합니다.
  - 이 후 사용하는 사용자는 등록한 카드를 NFC 리더기에 대면 인증이 완료되어 무인대여함이 열리게 됩니다.

### 4.1.3 Controller 
  :pushpin: [코드 확인](https://github.com/SpaceRentalUnmannedSystem/ADS/blob/master/ads/src/main/java/kr/co/ads/member/MemberController.java#L48)
- **요청 처리**
  - Controller에서는 요청을 화면단에서 넘어온 요청을 받고, Service 계층에 로직 처리를 위임합니다.

- **결과 응답**
  - Service 계층에서 넘어온 로직 처리 결과(메세지)를 화면단에 응답해줍니다.

### 4.1.4 Service 
  :pushpin: [코드 확인](https://github.com/SpaceRentalUnmannedSystem/ADS/blob/master/ads/src/main/java/kr/co/ads/member/MemberServiceImpl.java#L18)

- **NFC 수신()** :pushpin: [코드 확인](https://github.com/SpaceRentalUnmannedSystem/ADS/blob/master/ads/src/main/java/kr/co/ads/member/MemberRepositoryImpl.java#L64)
  - 사용자가 카드 정보 갱신을 할 때 NFC기기를 통해 UUID 값을 읽어옵니다.

- **Repository 계층으로 인계** 
  - 위에서 받은 카드 UUID 값을 가진 DTO를 Repository 계층으로 인계한다.

### 4.1.5 Repository 
  :pushpin: [코드 확인](https://github.com/SpaceRentalUnmannedSystem/ADS/blob/master/ads/src/main/java/kr/co/ads/member/MemberRepositoryImpl.java#L44)

- **카드 UUID 값을 가진 URL을 전송**
  - SRUS 서버로 카드 UUID 값을 가진 URL을 전송시킨다.
  - 이 후 SRUS 서버에서 데이터베이스에 접근해서 값을 바꾼다.

</div>
</details>

<details>
<summary><b>3.2 결제 핵심 설명 펼치기</b></summary>
<div markdown="1">

### 4.2.1 사용자 요청
![결제1](https://user-images.githubusercontent.com/63217462/172066260-c4ead5cc-21ed-4e20-8f03-a1aa2cc7d50a.PNG)

 
![결제2](https://user-images.githubusercontent.com/63217462/172066269-b4091361-8234-489f-81ae-37bad36e7c78.PNG)

  
![결제3](https://user-images.githubusercontent.com/63217462/172066274-df611b3d-2d0c-45d5-89e1-76d4faab4903.PNG)

  
- **아임 포트 API를 통한 결제** :pushpin: [코드 확인](https://github.com/SpaceRentalUnmannedSystem/SRUS/blob/master/srus/src/main/webapp/WEB-INF/jsp/payment/confirmationform.jsp#L93)
  - 아임포트 API 문서를 참고하여 아임포트에 API요청
</div>
</details>

</br>


## 5. Applicaiont UI
자세한 사항은 👉 [화면정의서7.0.pptx](https://github.com/SpaceRentalUnmannedSystem/SRUS/files/8840606/7.0.pptx)

</br>

## 6. 시스템 구성도
![image](https://user-images.githubusercontent.com/63217462/172065943-0480c265-d5ac-4458-b4c4-bbd4d59000e0.png)

## 7. ERD 설계
![image](https://user-images.githubusercontent.com/63217462/145765596-2f0d3a22-19da-488e-a85f-5c21709345f8.png)


## 8. 프로젝트 진행 시 어려웠던 점
### 8.1 분석 및 설계
- 저는 프로젝트를 진행할때 분석 및 설계 문서화를 진행한것이 이번 프로젝트가 처음입니다. 그래서 분석 및 설계를 하는데 어려움을 겪었습니다.
- 하지만 분석 및 설계를 팀원들과 같이 진행하고, 구현에 들어가니 기존보다 협업이 잘되고, 구현이 쉽게된다는것을 알게되었습니다.

### 8.2 라즈베리 통신 및 무인대여함 제작
- 메인 서버를 두고 각각 인증데스크 서버, 무인대여함 서버를 만들고, API 통신을 해야되는데 라즈베리 통신 설정에 어려움을 겪었습니다.  
- 각각 ADS, RBS 서버를 따로 만들어서 API 통신하는 것으로 해결하였습니다.
- 무인대여함은 직접 제작하여 카드를 찍었을때 모터를 이용해 무인대여함이 열리게 만들었습니다.

### 8.3 결제 및 결제 취소
- 아임 포트에서 식별코드를 이용하여 API 요청을 통해 결제 및 결제 취소를 구현했습니다.
- 결제 취소가 가능한 기간을 결정해야 했었는데 무인 대여함 대여 시작일 전까지 가능한 것으로 결정하였습니다.
</br>
