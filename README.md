# Wanted pre onboarding

## Preview
<div
     float : left>
<img width="200" alt="Screen Shot 2022-06-22 at 4 35 46 PM" src="https://user-images.githubusercontent.com/73249915/174971482-944e4f43-a333-404f-9441-e3cdcc776187.png">
<img width="200" alt="Screen Shot 2022-06-22 at 4 35 52 PM" src="https://user-images.githubusercontent.com/73249915/174971501-25c56c04-4c2a-4290-9cf6-daa37df344e0.png">
</div>

## 구현 방식
1. MVC 패턴 적용
2. URLSession을 사용한 JSON 파싱
3. NSCache를 사용한 Image Load 구현
4. AutoLayout 적용
5. TableView 사용

## 어려웠던 점
1. 여러 JSON파일을 파싱할 때 가져온 데이터를 Model의 Manager부분에서 모아두고 사용하려했지만 closure사용에 대한 미숙으로 tableView에서 JSON파일을 요청하는 것으로 구현
2. API를 요청할 때 기존 도시들의 이름으로 진행했는데, 단어 중간에 hypen이 있는 것들은 데이터를 받아오지 못해서 그에 맞는 문자열을 따로 생성함
  => 이것들을 하나의 구조체로 만들어서 관리하는 것이 훨씬 깔끔할 것 같음
3. cell에서 하나씩 data 배열에 채워넣는 과정에서 요청한 순서대로 들어가지 않아 첫번째 화면과 관련 없는 데이터들이 전송됨 그래서 기존 nameList를 이용해서 일치하는 data를 찾은 다음에 다시 넘겨주는 것으로 진행
  => 비동기로 진행되다보니 먼저 완료된 것부터 실행되는 문제인 것 같은데, 이 부분을 컨트롤하는 방법은 아직 잘 모르겠음
4. autoLayout을 아직까지 내가 원하는 모양으로 다룰 수 있는 능력이 부족함
