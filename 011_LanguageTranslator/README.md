# Day019: Naver Papago API를 활용한 번역기 만들기

## STEP1. 과제 기본 요구사항

### Option 1. 언어 감지 API 활용

- [x] 1. 텍스트 입력 후 번역 버튼을 클릭하면, 언어 감지 API를 통해 langCode를 응답값으로 받음
- [x] 2. langCode를 받고 난 후 Papago 번역 API를 요청(target 언어는 고정)
- [x] 3. 번역 응답값을 TextView에 보여줌

### Option 2. PickerView를 활용: Papago 번역 API만 활용할 것

- [x] 1. PickerView를 활용해 source와 target을 선택할 수 있는 View 추가
- [x] 2. 선택 값에 따라 번역을 요청하고 번역 결과를 TextView에 보여줌

## 고민한 점

### TextField에 아예 입력을 막을 수는 없을까?

TextField에 inputView를 통해 Picker를 할당한다고 해도 외부 키보드의 입력을 막을 수는 없어서 사용자의 입력을 막을 수 있는 방법이 없는지 찾아보게 되었다.

UITextFieldDelegate - [textField(\_:shouldChangeCharactersIn:replacementString:)](https://developer.apple.com/documentation/uikit/uitextfielddelegate/1619599-textfield)

    Asks the delegate whether to change the specified text.
    delegate에게 지정된 텍스트의 변경 여부를 묻는다.

    Parameters
    - textField: 텍스트를 담고 있는 text field
    - range: 대체될 문자의 범위
    - string: 지정된 범위의 대체 문자열. 입력하는 동안 이 매개변수에는 일반적으로 입력된 새 문자 하나만 포함되지만 사용자가 텍스트를 붙여넣는 경우 더 많은 문자가 포함될 수 있다. 사용자가 하나 이상의 문자를 삭제하면 대체 문자열은 비게 된다.

    Return Value
    지정된 텍스트 범위를 교체해야 하는 경우 true, 그렇지 않으면 false로 이전상태를 유지한다.

    Discussion
    텍스트 필드는 사용자 작업으로 인해 텍스트가 변경될 때마다 이 메서드를 호출합니다. 이 메서드를 사용하여 사용자가 입력한 텍스트의 유효성을 검사합니다. 예를 들어 이 방법을 사용하여 사용자가 숫자 값 외에는 아무것도 입력하지 못하도록 할 수 있습니다.

텍스트 필드에서 입력이나 삭제가 일어날때마다 이 메서드가 호출된다. 이게 "replace"라는 표현 때문에 이해하기가 좀 헷갈렸다. 사용자가 입력을 시작하면, textField의 텍스트가 통째로 들어오는게 아니고 입력된 딱 그 문자, 혹은 붙여넣기한 그 텍스트가 string 매개변수로 들어온다. 그리고 range로 그 텍스트의 범위가 인덱스 범위로 들어온다. 이때 true 값을 리턴하면 입력을 허락한다는 뜻이고, false 값을 리턴하면 입력을 거부하겠다는 뜻이 된다.

예를 들어 숫자만 입력 받아야 한다면, 입력되는 그 순간순간의 문자 하나하나, 혹은 붙여넣기한 텍스트를 딱 검사해서 얘가 숫자가 아니면 false를 리턴하면 사용자가 보기에 textFeild에 입력이 반영되지 않는걸로 보일 수 있다. 그래서 이 메서드의 return 값을 무조건 false로 해두면 키보드로 입력하는 어떤 입력이던 간에 거부할 수 있게 된다.

### 아예 Copy, Paste 같은 Menu도 안뜨게 할 수는 없을까?

입력은 막았지만, 텍스트필드를 선택 했을 때 자꾸 복사, 붙여넣기 버튼이 달린 메뉴가 뜨는게 거슬렸다. 위 방법으로 붙여넣기해도 입력이 안될테지만, 아예 해당 메뉴가 안뜬다면 더 좋을 것 같았다. 찾아보니 이 부분은 `UIResponder` 클래스의 `canPerformAction(_:withSender:)` 인스턴스 메서드를 손봐야 했는데, 일단 뜬금없이 `UIResponder`가 왜 나왔는지, 뭐하는 놈인지부터 알아보자.

    UIResponder -> UIView -> UIControl -> UITextField

UITextField는 UIControl을 상속받고, UIControl은 UIView를 상속받는다. UIView는 UIResponder를 상속받고 있어서 결론적으로 UITextField는 이 세가지 상위클래스의 형질을 모두 물려받았다고 할 수 있다. (UIResponder는 NSObject를 상속 받는데, NSObject는 컴포넌트들의 단군 할아버지 격이다.)

#### [UIResponder](https://developer.apple.com/documentation/uikit/uiresponder)

UIResponder에 대한 공식문서를 좀 읽어보면,

    이벤트에 응답하고 처리하기 위한 추상 인터페이스

    Overview
    UIResponder의 인스턴스인 Responder 객체는 UIKit 앱의 이벤트 처리 백본을 구성한다. UIApplication 객체, UIViewController 객체 및 모든 UIView 객체(UIWindow 포함)를 비롯한 많은 주요 객체는 Responder이기도 하다. 이벤트가 발생하면 UIKit은 이벤트를 처리하기 위해 앱의 Responder 객체로 디스패치(발송)한다.

    touch events, motion events, remote-control events, and press events 등 여러 종류의 이벤트가 있고, 특정 유형의 이벤트를 처리하려면, Responder가 해당 메서드를 override 해야 한다. 예를 들어 touch events를 처리하기 위해서 Responder는  touchesBegan(_:with:), touchesMoved(_:with:), touchesEnded(_:with:), 그리고 touchesCancelled(_:with:) 메서드를 구현한다. 터치의 경우 응답자는 UIKit에서 제공하는 이벤트 정보를 사용하여 해당 터치의 변경 사항을 추적하고 앱의 인터페이스를 적절하게 업데이트 한다.

    이벤트 처리 외에도 UIKit Responder는 처리되지 않은 이벤트를 앱의 다른 부분으로 전달하는 것도 관리한다. 지정된 Responder가 이벤트를 처리하지 않으면 해당 이벤트를 Responder 체인의 다음 이벤트로 전달한다. UIKit은 어떤 객체가 이벤트를 수신해야 하는지 결정하기 위해 미리 정의된 규칙을 사용하여 Responder 체인을 동적으로 관리합니다. 예를 들어 view는 이벤트를 super view로 전달하고 계층 구조의 Root view는 이벤트를 view controller로 전달합니다.

    Responder는 UIEvent 객체를 처리하지만 input view를 통해 사용자 지정 input을 받을 수도 있다. 시스템의 키보드는 입력 보기의 가장 확실한 예이다. 사용자가 화면에서 UITextField 및 UITextView 객체를 탭하면 보기가 첫 번째 responder가 되고 시스템 키보드인 input view를 표시합니다. 마찬가지로 custom input view를 만들고 다른 responder가 활성화될 때 표시할 수 있습니다. custom input view를 responder와 연결하려면 해당 view를 responder의 inputView 속성에 할당합니다.

즉 UIResponder는 UIKit 앱의 모든 이벤트를 처리하고 응답하는 친구다. 실제로 UITextField도 input view 프로퍼티가 있고, textField의 여러 이벤트들을 처리할 수 있는 메서드(textFieldShouldBeginEditing(\_:) 라던지...!)들이 있다.

이제 본론으로 넘어가서 이 UIResponder에서 Menu를 비활성화 하는 `canPerformAction(_:withSender:)` 메서드에 대해 알아보자.

[`canPerformAction(_:withSender:)`](https://developer.apple.com/documentation/uikit/uiresponder/1621105-canperformaction)

    사용자 인터페이스에서 지정된 명령을 활성화 또는 비활성화하도록 수신 응답자에게 요청한다.

    Parameter
    - action: command와 관련된 메서드를 식별하는 selector. 편집 메뉴의 경우 UIResponderStandardEditActions 약식 프로토콜(예: copy:)에서 선언한 편집 메서드 중 하나이다.
    - sender: 이 메서드를 호출하는 객체. 편집 메뉴 command의 경우 이것은 공유된 UIApplication 객체다. 컨텍스트에 따라 명령을 활성화해야 하는지 여부를 결정하는 데 도움이 되는 정보를 sender로 쿼리할 수 있다.

    Return Value
    action으로 식별된 명령이 활성화되어야 하는 경우 true이고 비활성화되어야 하는 경우 false.

    Discussion
    이 메서드의 기본 구현은 responder 클래스가 요청된 action을 구현하는 경우 true를 반환하고 그렇지 않은 경우 다음 responder를 호출한다. 서브클래스는 이 메서드를 override하여 현재 상태에 따라 메뉴 command를 활성화 할 수 있다. 예를 들어, selection이 있으면 Copy command를 활성화 하거나 pasteboard(clipboard나 복사되어져 있는 것)가 올바른 pasteboard 표시 타입의 데이터를 담고 있지 않으면 Paste command를 비활성화 한다. 만약 클래스가 command에서 false를 반환하더라도 responder 체인에서 상위에 있는 또 다른 responder가 true를 반환하여 command를 활성화 할 수 있다는 것에 주의해야 한다.

    이 메서드는 동일한 action에 대해 다른 sender와 함께 한 번 이상 호출될 수 있다. nil을 포함한 모든 종류의 sender에 대비해야 한다.

그러니까 매개변수로 받아오는 action과 sender를 적절히 조건문으로 추려내서 이 sender에서 보이고 싶지 않은 action menu만 false를 반환하면 해당 action menu는 뜨지 않는다는 얘기인거 같다.

이 메서드를 override 하려면 UITextField의 view controller에서 어떻게 할 수는 없고, UITextField를 상속 받는 사용자 정의 클래스를 만들어서 거기에서 override 해야한다. 그래서 UITextFieldForPicker를 만들고 해당 클래스 내에서 조건문없이 그냥 모든 메뉴를 띄우지 않도록 false를 반환해주었더니 더이상 불필요한 메뉴가 뜨지 않았다.
