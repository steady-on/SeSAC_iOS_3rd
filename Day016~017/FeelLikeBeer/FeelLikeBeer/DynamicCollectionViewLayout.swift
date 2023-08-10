//
//  DynamicCollectionViewLayout.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/08/10.
//

import UIKit

// MARK: [Kodeco] UICollectionView Custom Layout Tutorial: Pinterest
/// https://www.kodeco.com/4829472-uicollectionview-custom-layout-tutorial-pinterest

protocol DynamicCollectionViewLayoutDelegate: AnyObject {
    func collectionView(_ collectionView : UICollectionView, heightForItemAtIndexPath  indexPath : IndexPath ) -> CGFloat
}

class DynamicCollectionViewLayout: UICollectionViewLayout {
    // MARK: 구현하는 메서드 목록
    /// collectionViewContentSize : 이 메서드는 컬렉션 뷰 콘텐츠의 너비와 높이를 반환합니다. 보이는 콘텐츠 뿐만 아니라 전체 컬렉션 뷰 콘텐츠의 높이와 너비를 반환하도록 구현해야 합니다. 컬렉션 뷰는 이 정보를 내부적으로 사용하여 스크롤 뷰의 콘텐츠 크기를 구성합니다.
    /// prepare() : 레이아웃 작업이 일어나려고 할 때마다 UIKit이 이 메서드를 호출합니다. 컬렉션 뷰의 크기와 항목의 위치를 ​​결정하는 데 필요한 계산을 준비하고 수행할 수 있는 기회입니다.
    /// layoutAttributesForElements(in:) : 이 메서드에서는 지정된 사각형 내부의 모든 항목에 대한 레이아웃 속성을 반환합니다. 컬렉션 뷰에 속성을 UICollectionViewLayoutAttributes의 배열로 반환합니다.
    /// layoutAttributesForItem(at:) : 이 메서드는 컬렉션 보기에 주문형 레이아웃 정보를 제공합니다. 이를 재정의하고 요청된 항목의 레이아웃 속성을 반환해야 합니다 indexPath.
    
    // 1. 델리게이트의 참조 유지
    weak var delegate: DynamicCollectionViewLayoutDelegate?
    
    // 2. 레이아웃을 구성하기 위한 속성 2개; 열 수와 셀 패딩
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 6
    
    // 3. 계산된 속성을 캐시하는 배열
    /// prepare()를 호출하면, 모든 아이템에 대한 속성을 계산하고 캐시에 추가함
    /// collection view가 나중에 레이아웃 속성을 요청할 때, 매번 다시 계산하는 대신 효율적으로 캐시를 쿼리할 수 있음
    private var cache: [UICollectionViewLayoutAttributes] = []
    
    // 4. content size를 저장하기 위한 프로퍼티 2개
    /// 사진을 추가할 때 contentHeight를 증가시키고 collection view 너비와 설정된 내용을 기반으로 contentWidth를 계산함
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    // 5. collectionViewContentSize는 collection view의 contents 사이즈를 반환
    /// 앞 단계에서 계산한 contentWidth와 contentHeight를 사용
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // MARK: - prepare()
    /// 레이아웃 작업이 일어나려고 할 때마다 UIKit이 이 메서드를 호출함
    /// 컬렉션 뷰의 크기와 항목의 위치를 ​​결정하는 데 필요한 계산을 준비하고 수행할 수 있는 기회임
    override func prepare() {
        // 1. cache가 비어있고 collection view가 존재할때만 레이아웃 속성들을 계산
        guard cache.isEmpty, let collectionView = collectionView else { return }
        
        // 2. 열 너비를 기준으로 모든 열의 x좌표로 xOffset 배열을 선언하고 채움. yOffset 배열은 모든 열의 y위치를 추적함.
        /// 각 열의 첫번째 아이템의 offset이므로 yOffset은 0으로 모든 값을 초기화 한다.
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        var column = 0
        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
        
        // 3. 이 특정 레이아웃은 section이 하나만 있으므로 첫번째 섹션의 모든 항목을 반복함
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            // 4. frame 계산을 수행함. width는 셀 사이의 padding이 제거된 상태에서 이전에 계산된 cellWidth임.
            /// delegate에게 아이템의 높이를 요청한 다음, 이 높이와 top과 bottom에 대해 이전에 정의된 cellPadding을 기준으로 frame의 높이를 계산함.
            /// delegate가 설정되지 않은 경우는 cell 높이 기본값을 사용함. 그리고 이것을 현재 열의 x및 y오프셋과 결합하여 insetFrame 속성에서 사용하도록 만듦.
            let itemHeight = delegate?.collectionView(collectionView, heightForItemAtIndexPath: indexPath) ?? 180
            let height = cellPadding * 2 + itemHeight
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // 5. UICollectionViewLayoutAttributes의 인스턴스를 생성하고 insetFrame을 사용하여 프레임을 설정, 그리고 cache에 속성을 추가함.
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // 6. 새로 계산된 아이템의 높이를 처리하도록 확장. 그리고 프레임을 기준으로 현재 열의 yOffset을 증가시킴. 마지막으로 다음 아이템이 다음 열에 위치될 수 있게 열을 증가시킴
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + height
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    // MARK: - layoutAttributesForElements(in:)
    /// 이 메서드에서는 지정된 사각형 내부의 모든 항목에 대한 레이아웃 속성을 반환합니다. 컬렉션 뷰에 속성을 UICollectionViewLayoutAttributes의 배열로 반환합니다.
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        // 캐시를 순회하면서 해당 프레임이 collection view가 제공하는 올바른 프레임과 교차하는지 확인
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                // 해당 rect와 교차하는 프레임이 있는 attributes를 visibleLayoutAttributes에 추가하고 최종적으로 반환함
                visibleLayoutAttributes.append(attributes)
            }
        }
        
        return visibleLayoutAttributes
    }
    
    // MARK: - layoutAttributesForItem(at:)
    /// 이 메서드는 컬렉션 보기에 주문형 레이아웃 정보를 제공합니다. 이를 재정의하고 요청된 indexPath의 item의 레이아웃 속성을 반환해야 합니다.
    // 캐시에서 요청된 indexPath에 해당하는 레이아웃 특성을 검색하고 반환
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
