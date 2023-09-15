# Day 11. Bookworm; 도서 검색 및 독서기록 관리 앱

> Commit: https://github.com/steady-on/SeSAC_iOS_3rd/issues/1#issue-1828684368

<img alt="image" width="1115" src="https://user-images.githubusercontent.com/73203944/257420647-e2c2363f-475d-4691-9396-bf23d3bdbca4.png"> 
참고화면) 앱 삐삐북 메인화면 참고

## 요구사항

- Main뷰는 CollectionViewController
- 검색화면, 상세 화면은 ViewController
- CollectionViewCell 선택 시 상세화면 push
- 영화 제목을 값 전달 하여 상세화면의 타이틀로 보여줌
- 메인화면에서 검색 아이콘 선택 시 검색뷰가 FullScreen으로 Present, 닫기 버튼 클릭 시 Dismiss 됨.

## STEP 1

- [x] Storyboard로 View Layout 구현
- [x] code로 Layout Setting
- [x] Data 연결
- [x] 검색 뷰 연결
- [x] DetailView 연결

## STEP 2

- [x] Segment로 CollectionView와 TableView 보여주기
- [x] TableView에서 SwipeAction으로 북마크, 삭제 넣기
- [x] CollectionView에서 꾹눌러 북마크, 삭제

## 고민한 점

### UITextView의 알 수 없는 공백

<img src="https://github.com/steady-on/SeSAC_iOS_3rd/assets/73203944/255b4c25-3374-4c36-a069-979bff3e81cd">

- TextView의 상하좌우로 알 수 없는 빈여백이 있어서 이걸 어떻게 없앨 수 있는지 알아보았다.

#### [textContainerInset; Apple developer Document](https://developer.apple.com/documentation/uikit/uitextview/1618619-textcontainerinset)

> The inset of the text container's layout area within the text view's content area.
>
> ### Discussion
>
> This property provides text margins for text laid out in the text view. By default the value of this property is (8, 0, 8, 0).

> text view의 컨텐츠 영역 안의 text container의 레이아웃 영역의 inset.
>
> ### 논의
>
> 이 속성은 text view에 배치된 텍스트에 대한 텍스트 여백을 제공합니다. 기본적으로 이 속성의 값은 (8, 0, 8, 0) 입니다.

이 속성 때문에 text의 위,아래로 8의 여백이 생겨있었고, view hierachy에서 확인할 수 있었다.

#### [lineFragmentPadding; Apple developer Document](https://developer.apple.com/documentation/uikit/nstextcontainer/1444527-linefragmentpadding)

> The value for the text inset within line fragment rectangles.
>
> ### Discussion
>
> The padding appears at the beginning and end of the line fragment rectangles. The layout manager uses this value to determine the layout width. The default value of this property is 5.0.
>
> Line fragment padding is not designed to express text margins. Instead, you should use insets on your text view, adjust the paragraph margin attributes, or change the position of the text view within its superview.

> 선 조각 사각형 내의 text inset을 위한 값(?)
>
> ### 논의
>
> 선 조각 직사각형의 시작과 끝에 padding이 나타난다. 레이아웃 매니저는 이 값을 사용하여 레이아웃 너비를 결정한다. 이 프로퍼티의 기본 값은 5.0이다.
>
> 선 조각 padding은 text의 margins을 표현하도록 설계되지 않았다. 대신에, text View의 inset을 사용하거나 문단 margin 속성을 조정하거나 해당 뷰 내의 text view의 위치를 변경해야 한다.

사실 정확하게 선 조각 직사각형(line fragment rectangle)이 뭔지는 모르겠는데, view hierachy에서 text를 감싸고 있는 직사각형을 가리킨다고 판단했다. 그렇게 보면, 이 사각형의 시작과 끝, 그러니까 leading과 trailing에 약간의 여백이 있는 것을 볼 수 있다. 이 속성의 기본 값이 5여서 전체적으로 약간 들여쓰기 한 것 처럼 보였던 것이다. 그래서 마찬가지로 이 속성도 0으로 맞춰주면 text를 감싼 여백이 모두 사라진다.

<br>

# Day 12.

<img alt="image" width="1125" src="https://user-images.githubusercontent.com/73203944/257463483-f30f027e-0b9f-4eca-b582-0f5f2981420c.png">

## STEP 1. 과제 기본 요구사항

- [x] 1.  “좋아요” 기능 구현 하기 → Already done
- [x] 2.  상세화면 디자인 및 값 전달을 통해 데이터 표현

## STEP 2. 추가 미션 및 나만의 구현 목표

- [x] 1.  검색뷰에서 검색결과 TableView로 보여주기
- [ ] ~~2. Streachy Header View로 스크롤에 따라 검색창을 가리거나 꺼내기~~
- [x] 3.  TableViewCell에 버튼을 추가해서 읽음상태 변경하기
- [ ] 4.  image를 url을 받아 비동기적으로 가져오기

## 고민한 점

### TableViewCell에서 읽기 상태를 변경했는데, Data에 반영되지 않는 것처럼 보이는 문제

#### 구현방법

1. `tableView(_:cellForRowAt:)` 메서드에서 cell의 View controller를 호출
2. button tag에 indexPath.row값을 할당
3. Cell class에서 tag 값으로 받은 row를 bookData 배열의 index 값으로 활용하여 해당 Book 객체의 stateOfReading 값을 변경

위와 같은 방식으로 코드를 구현했는데, 이상하게 값이 바뀌지 않았다. 그래서 bookData와 segment의 IBAction에까지 여러 곳에서 data를 출력해봤는데, 원하는 객체의 값이 바뀌지 않는 것을 알 수 있었다. 그래서 혹시나 tag값이 잘 못 들어가고 있는 것은 아닌지 확인해보니 view에 보여지는 row값과는 전혀 다른 tag값이 들어가고 있었다. 그래서 0번째 셀의 값을 변경하면 아예 4번째 셀의 값이 바뀌고 있었다.

알고보니, tag를 할당하는 코드와 button에 menu를 만들어 할당하는 코드의 순서가 잘못되어 벌어진 문제였다. button의 기능을 나중에 구현하게 되면서 `tableView(_:cellForRowAt:)`에서 `configureCell` 메서드를 먼저 호출하고 다음 줄에 button의 tag값을 할당하다보니 `configureCell`에서 이미 menu가 만들어져 할당된 후 나중에 tag값이 부여되었던 것이다. 그래서 엉뚱한 tag값이 들어가서 생기는 버그였다.

<br>

# Day 13

## STEP1. 과제 기본 요구사항

- [x] 1.  UIViewController에 UITableView를 구성하고 tableView의 Header에 CollectionView를 추가(상단은 수평스크롤, 하단은 수직스크롤)

- [x] 2.  각 tableViewCell/collectionCell 선택 시 DetailView로 FullScreen 화면 전환
  - [x] 메인화면에서는 Push 방식
  - [x] 둘러보기화면에서는 Present 방식

<br>

# Day 14

## STEP1. 과제 기본 요구사항

- [x] 1.  UISearchBar를 활용하여 실시간 검색 기능 구현
- [x] 2.  상세화면에 UITextView를 추가하고 Placeholer 기능 구현

<br>

# Day 18: Kakao 도서 API를 활용하여 책 검색 화면을 재구성하기

## STEP 1. 과제 기본 구현

- [x] 1. 도서 검색기능 구현
- [x] 2. 페이지네이션 기능

## 고민한 점

### Image data를 어디서 불러오면 좋을까?

Kakao의 검색 API를 통해서 받아온 책의 정보에는 책 표지의 이미지가 URL로 들어있어서 해당 URL에서 data를 받아서 ImageView에 넣어줘야 했다. 그런데 이미지의 데이터를 받아오는 코드의 위치가 많이 고민되었다.

처음으로 생각했던 것은 책의 정보 자체를 받아오는 작업이기 때문에 `KakaoAPIManager`에서 image 데이터를 받아오는 메서드를 작성할까 했으나 해당 작업은 KakaoAPI와는 직접적인 관련이 없어서 맞는 자리가 아니라는 생각이 들었다.

두번째로는 책에 대한 정보이므로 `Book` 구조체에서 인스턴스 메서드로 작성하려고 했는데, 이 경우 구조체가 원시타입만이 아니라 프레임워크의 타입까지 가지고 가서 너무 무거워져 버리는 것 같았고, 단순히 책에 대한 정보를 담고있어야할 구조체가 쓸데 없는 일을 맡아서 하는 것 같았다.

그래서 좀 더 고민해 본 결과 이것은 ImageView가 자신이 담을 이미지의 데이터를 책임지고 가지고 오는게 맞다는 생각이 들어서 최종적으로는 ImageView의 extension으로 인스턴스 메서드를 작성하게 되었다.

```swift
func loadData(url: String) {
    DispatchQueue.global().async {
        guard let url = URL(string: url),
              let data = try? Data(contentsOf: url) else { return }

        DispatchQueue.main.async {
            self.image = UIImage(data: data)
        }
    }
}
```

데이터를 불러오는 작업 자체는 main에서 할 필요가 없으므로 global 스레드에서 데이터를 가지고 오고, 마지막에 불러온 데이터로 view를 업데이트 할 때만 main 스레드에서 작업하도록 메서드를 구성했다.
