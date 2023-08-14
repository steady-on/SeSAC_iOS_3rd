# Day 16~17. Networking 연습하기

## STEP 1-1. Lottery API로 구현하기

- [x] 앱 실행 시 가장 최근 회차(1079회)를 조회하여 View에 보여줌
- [x] 이후 텍스트 필드 선택 시 회차를 선택할 수 있는 PickerView가 보여진
- [x] Picker가 DidSelect 되는 순간 해당 회차에 대한 값을 가져와서 보여줌

## STEP 1-2. Beer API로 구현하기

- [x] 버튼을 누르면 맥주를 랜덤으로 추천해주는 앱
- [x] 맥주 리스트를 받아서 TableView나 CollectionView에 구현
- [x] 표현되는 데이터의 종류는 최소 3가지 이상이어야 함

## 고민한 점

### App 실행 시 탭바는 가리지 않으면서 컨텐츠는 가려주는 Cover 띄우기

"오늘의 맥주 추천" 컨텐츠는 바로 보이기보다 가려져 있는 상태에서 버튼을 탭하면서 보여지면 두근두근 할 수 있는 재미가 있을 것 같아서 기획하게 되었다.

#### 1. CoverView를 만들고 viewDidLoad에서 present를 호출!했다. 뭔가 에러가 생기는건 아닌데 터미널에 신경쓰이는 문구가 나타났다.

> "whose view is not in the window hierarchy"

검색해보니 `viewDidLoad`에서 모달뷰를 띄우려고 할 때 발생하는 오류로 ViewController의 LifeCycle과 관련된 이슈였다.

공식문서를 살펴 보면 `viewDidLoad`는

> "This method is called after the view controller has loaded its view hierarchy into memory."
> "이 메서드는 view controller가 해당 뷰 계층을 메모리에 로드한 후에 호출된다."

이렇게 설명되어 있다.
이제 막 메모리에 올리고 나서 자기가 가진 인스턴스 프로퍼티들을 만들고 view controller의 전체 수명주기 동안 존재할 view를 만들려는, 그러니까 아직 view controller가 완성되지 않은 때이다.

그런데 바로 또 위에 올릴 새로운 ModalView가 호출된 것이다. 아직 1층도 덜지었는데 2층을 지으라고 하는 격이었던 것이다. 다시 한번 로그를 잘 보면,

> "window 계층에 없는 view"

라고 말하고 있다. 이를 토대로 생각해보면, view controller가 완성되고 hierarchy에 올라간 뒤에 모달을 불러주면 안정적으로 불러올 수 있겠다는 생각이 든다! 그럼 그 시점은 언제 알 수 있을까?

`viewDidAppear`의 정의를 한번 살펴보면,

> Notifies the view controller that its view was added to a view hierarchy.
> view controller의 view가 view hierarchy에 추가되었음을 알린다.

빙고! viewDidAppear에서 modal을 띄워주니까 더이상 해당 메세지는 나오지 않게 되었다!

#### 2. modal을 닫지 않고 탭을 이동했다가 다시 돌아와 modal을 닫으면, view가 보이지 않는 문제

modal로 띄운 view가 Tab bar를 가리지 않도록 parentView의 바탕에 Navigation Controller로 깔아주고, modal의 `modalPresentationStyle`을 `overCurrentContext`로 주었다. 그런데 이 modal을 닫지 않고 다른 탭으로 이동했다가 돌아와서 modal을 닫으니까 view가 텅 비어있었다. 그래서 view hierarchy를 확인해보니 modal view 아래에 있어야 할 view가 없었다.

바로 구글링....! stackoverflow에서 같은 문제를 겪은 사람을 찾을 수 있었다.

https://stackoverflow.com/questions/50015547/remove-black-background-when-switching-tab-of-uitabbarcontroller

답변으로 `viewDidLoad`에 `definesPresentationContext = true` 명령어를 추가해주라고 하는데... 이게 뭔지, 원인이 무엇인지 알아보았다.

`definesPresentationContext`는 UIViewController의 인스턴스 프로퍼티이고, 정의는 다음과 같다.

> A Boolean value that indicates whether this view controller's view is covered when the view controller or one of its descendants presents a view controller.
>
> 뷰 컨트롤러 또는 하위 구성원 중 하나가 뷰 컨트롤러를 표시할 때 이 뷰 컨트롤러의 뷰가 포함되는지 여부를 나타내는 부울 값이다.

.... 좀 더 자세히 살펴보자.

> #### Discussion
>
> When using the UIModalPresentationStyle.currentContext or UIModalPresentationStyle.overCurrentContext style to present a view controller, this property controls which existing view controller in your view controller hierarchy is actually covered by the new content. When a context-based presentation occurs, UIKit starts at the presenting view controller and walks up the view controller hierarchy. If it finds a view controller whose value for this property is true, it asks that view controller to present the new view controller. If no view controller defines the presentation context, UIKit asks the window’s root view controller to handle the presentation.
>
> `currentContext`나 `overCurrentContext` 스타일을 사용해서 view controller를 띄울 때, 이 프로퍼티는 view controller 계층에 존재하는 view controller가 실제로 새로운 컨텐트로 덮일 것인지를 컨트롤 한다. context 기반의 presentation이 발생하면, UIKit은 지금 나타나는 view controller에서 시작해서 view controller 계층을 올라간다. 그러다가 이 프로퍼티가 true인 view controller를 찾으면, 그 view controller에게 새로운 view controller를 나타낼 것을 요청한다. 프리젠테이션 컨텍스트를 정의하는 view controller가 없으면 UIKit은 window의 root view controller에서 프리젠테이션을 처리하도록 요청한다.

그러니까 정리하자면, 이건 `currentContext`에 관련된 스타일을 사용하면 생기는 문제다. 해당 스타일을 사용해서 view를 present 하면 이 view가 어디를 기반으로 해서 나타날 것인지를 계산하게 되는데, 아무 설정도 하지 않는다면, window의 root view controller를 기반으로 해서 나타난다는 거다.

<img src="https://github.com/steady-on/SeSAC_iOS_3rd/assets/73203944/bdb02694-0286-421d-950a-1e6d3f30a652">

위 이미지로 보면, 내 경우는 Tab Bar Controller - Navigation Controller - Recommand Beer View Controller 순으로 view가 이어져 있는데, 아무 설정도 하지 않고 `currentContext` 기반의 모달을 present하면 가장 밑바닥에 있는 root view인 Tab Bar Controller에서 처리가 된다는 뜻이다. 아래의 view hierarchy를 보면 더 명확하게 알 수 있다.

<figure>
  <img src="https://github.com/steady-on/SeSAC_iOS_3rd/assets/73203944/45558f7d-d2f6-40cc-bef4-e5c673cc51e8">
  <figcaption>modal의 띄워진 상태에서 Tab을 이동했다가 돌아왔을 때의 view hierarchy</figcaption>
</figure>

그래서 이 present가 어떤 view controller를 기반으로 처리될지를 명시하는 프로퍼티가 `definesPresentationContext`이다. 이 속성을 원하는 view controller에서 `true`로 명시해주면, 해당 view controller에서 present를 처리하게 된다. 그래서 `Recommand Beer View`의 `viewDidLoad`에 다음 코드를 추가해주면,

`self.definesPresentationContext = true`

<img src="https://github.com/steady-on/SeSAC_iOS_3rd/assets/73203944/a3ebd598-7afc-4ebb-95b0-4e646c0ff27c">

위와 같이 Tab을 이동했다가 돌아와도 `Recommand Beer View`가 사라지지 않고 남아 있는 것을 확인할 수 있다.
