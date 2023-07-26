# SeSAC_iOS_3rd Day 007 Assignment

## STEP 0. 요구사항 정리 및 구상

<image src="https://github.com/steady-on/SeSAC_iOS_3rd/assets/73203944/48de0a67-8b33-4b80-b032-d839c697e06d">

## STEP 2. Pull down Button

### 고민한 점

- Library에서 Pull down Button을 발견해서 Tab을 다르게 하여 다른 View로 만들려고 하였으나, 결국 Pull down Button도 UIButton이었고, 버튼을 Long Press 했을 때 menu가 나오길 원했으므로 기존 Button의 menu 프로퍼티에 UIMenu를 만들어 할당해 주는 방법으로 구현했다.

- Library의 Pull down Button은 Button touch 시 바로 Menu가 나타나지만, 단순 Button에 UIMenu를 추가하면 Long Press 시 Menu가 나타난다.

- 한번의 동작으로 count를 여러번 올릴 수 있도록 EmotionManager에 addValue 메서드를 오버로드하여 추가로 count를 매개변수로 받아 해당 count만큼 value를 올려주도록 구현했다.

- IBAction의 경우 하나의 메서드에 여러 Button 객체를 연결하여 sender로 어떤 버튼이 눌린건지 구별할 수 있었다. 하지만, UIAction을 만들어서 Button의 menu 프로퍼티에 UIMenu를 만들어 할당하는 구현 방식에서, 일괄적으로 UIMenu를 만들어 각 버튼에 할당했을 때 sender를 어떻게 구별해야 할지에 대해 고민했다.

- 처음에는 UIActionHandler의 클로저 매개변수로 UIAction이 들어오는 것을 이용해서 UIAction의 sender 프로퍼티를 UIButton으로 다운캐스팅해서 구별하도록 구현했다.

- 그런데 UIButton의 배열을 forEach문으로 반복해서 각각의 Button에 UIMenu를 할당하는 방식으로 구현하다보니 UIMenu를 할당하는 메서드가 UIButton을 매개변수로 받게되었다. 이점을 이용해서 매개변수로 들어온 button을 UIActionHandler 안에서 호출하여 sender가 구별되도록 할 수 있었다.
