# fitpet-code-interview


## Weathers App 구성

말씀해주신 대로 Seoul, London, Chicago의 5일간의 날씨를 표시했습니다.
많은 양의 코드는 아니지만 프로덕션 레벨의 코드라고 생각하고 작성했습니다.

Weathers.xcworkspace에 
weather-app Project와 weathers-domain, weathers-data를 Static Library로 추가하여 
Clean Architecture로 구성했습니다.

API 요청은 AlamoFire, 의존성 주입을 위해 Swinject를 사용했고 
RxSwift및 기타 Rx 라이브러리들을 사용했습니다.


## Weathers App 흐름

HomeViewController 표시 ->
HomeReactor에서 데이터 요청 ->
UseCase에서 Repository를 통해 원하는 API 요청 함수 호출 ->
위치 정보 API 요청 후 위치 정보 로컬에 저장 -> 
날씨 정보 API 요청 ->
응답 받은 날씨 데이터가 HomeViewController에 전달되어 날씨 UI 표시 

 

