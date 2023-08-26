# Assignment Project 014

Codebase로 UI 그리기 연습하기

## STEP 1. 과제 요구사항

<img width="825" alt="스크린샷 2023-08-22 오후 4 31 17" src="https://github.com/steady-on/SeSAC_iOS_3rd/assets/73203944/47d934cd-de03-444d-9856-b73e42d6fcce">

- [x] example 1
- [x] example 2
- [x] example 3

## 고민한 점

### SecondExampleView

프로필 화면 하단의 버튼들을 만들면서 겪은 시행착오를 블로그에 정리해두었습니다.

[객체 그룹을 만들 때 Array(repeating:count:)를 사용하면 안되는 이유](https://steady-on.tistory.com/157)

### ThirdExampleView

- 반복되는 UI를 Custom 클래스로 만들기

  대화창의 말풍선을 UIView와 UILabel을 조합해서 인스턴스 생성시 text만 넣어주면 말풍선이 만들어지도록 했다. `convenience init`을 활용하여 들어갈 text를 매개변수로 받아서 UIView 내부에 들어갈 UILabel에 넣어주고, UIEdgeInsets로 layoutMargins를 설정하여 view가 자연스럽게 내부의 UILabel로부터 설정한 padding을 가지도록 해주었다.

  대화창에 들어갈 문자열은 String 배열로 만들어두고, forEach 문으로 순회하면서 객체를 생성해서 StackView에 넣어주도록 했다.
