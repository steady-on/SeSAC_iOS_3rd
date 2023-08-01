# Day 11. Bookworm; 도서 검색 및 독서기록 관리 앱

Commit: https://github.com/steady-on/SeSAC_iOS_3rd/issues/1#issue-1828684368

<img alt="image" width="1115" src="https://user-images.githubusercontent.com/73203944/257420647-e2c2363f-475d-4691-9396-bf23d3bdbca4.png"> 참고화면) 앱 삐삐북 메인화면 참고

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
