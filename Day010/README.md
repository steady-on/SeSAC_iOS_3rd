# SeSAC_iOS_3rd Day 010 Assignment

## 요구사항 정리 및 구상

### 요구사항 정리

- Custom TableViewCell을 활용

- 셀에는 영화의 포스터, 제목, 개봉일, 줄거리, 평점의 정보가 포함 되어 있어야 함

- 셀 디자인은 자유

### 구상

Naver에서 `영화`를 검색했을 때 나오는 화면을 구현하고자 함.

<img src="https://github.com/steady-on/SeSAC_iOS_3rd/assets/73203944/5d350594-089b-4725-ba1d-7a725aa321c0" width=600>

## 고민한 점

### Set horizontal compression resistance priority to 751

<img src="https://github.com/steady-on/SeSAC_iOS_3rd/assets/73203944/8b59ca0a-3250-47dc-993f-6e1e1049de65">

#### Compression resistance priority와 Hugging Priority

- UILabel과 같이 view의 크기가 내용물에 따라 유동적으로 달라지는 컴포넌트가 StackView에 여러개 들어갔을 때 컴포넌트들의 크기가 너무 커졌을 때 줄이거나 늘릴 것의 우선순위를 정할 수가 있는데, 그것들이 Compression resistance priority와 Hugging Priority다.

- Compression resistance priority

  `Returns the priority with which a view resists being made smaller than its intrinsic size.`

  뷰가 고유 크기보다 작게 생성되는 것을 거부하는 우선 순위를 반환합니다.

  기본값은 750이며, 우선순위가 높을 수록 컴포넌트 자신의 크기를 유지하고, 우선 순위가 낮을 수록 크기가 작아진다.

- Hugging Priority

  `Returns the priority with which a view resists being made larger than its intrinsic size.`

  뷰가 고유 크기보다 크게 작성되는 것을 거부하는 우선 순위를 반환합니다.

  기본값은 250이며, 우선 순위가 높을 수록 컴포넌트 자신의 크기를 유지하고, 우선 순위가 낮을 수록 크기가 커진다.

- Object들의 크기가 View에서 넘칠때 무언가는 작아져야 한다면 `Compression resistance priority`를 조정, Object들의 크기가 View의 크기보다 작을 때 무언가는 켜져서 빈공간을 채워야 한다면 `Hugging Priority` 조정하면 된다.

### UILabel과 UITextView에서 text의 윗부분에 생기는 알 수 없는 공백

<img src="https://github.com/steady-on/SeSAC_iOS_3rd/assets/73203944/255e15ec-07d5-4185-acb0-f60dcac86666" width=240>

- 영화의 줄거리를 UILabel에 넣었는데, 줄거리의 윗부분에 알 수 없는 공백이 생겼다.

- 구글 검색 결과

  1. `sizeToFit()` 메서드를 적용
  2. bottom constraint를 >= 0으로 설정해서 높이를 유동적으로 조절되게 만드는 것

  두가지 방법이 나왔으나 어떤 것도 문제가 해결되지 않았다.

- backgroundColor를 적용해보니 컴포넌트 내부에 있는 공백이었고, 텍스트가 짧아져서 truncating이 되지 않으면 공백이 없어졌다.

- 추측컨대 컴포넌트 자체의 높이보다 내용물이 생략되면서 측정되는 높이가 짧아지면, 컴포넌트 높이의 중간을 중심으로 컨텐츠가 렌더링되면서 아래로 내려가게 되는 것 같았다.

- `textView.textContainerInset = .zero` 코드를 적용하면 text 위에 생기는 공백을 없애고,
- `textView.textContainer.lineFragmentPadding = .zero` 코드를 적용하면 text 왼쪽에 생기는 공백을 없앤다.
