//
//  ViewController.swift
//  PracticeDiffableDataSource
//
//  Created by Roen White on 2023/09/15.
//

import UIKit

struct FocusMode: Hashable {
    let id = UUID().uuidString
    let title: String
    let subTitle: String?
    let icon: String?
    let iconColor: UIColor?
}

class Case1ViewController: UIViewController {
    
    enum SectionType: Int, CaseIterable {
        case modeSettings
        case shareToAllDevices
        case statusOfFocus
        
        var footer: String {
            switch self {
            case .modeSettings:
                return "집중 모드를 사용하여 기기를 사용자화하고 통화 및 알림 소리가 울리지 않도록 할 수 있습니다. 제어 센터에서 집중 모드를 켜고 끌 수 있습니다."
            case .shareToAllDevices:
                return "집중 모드는 모든 기기에 걸쳐 공유되며, 이 기기에서 집중모드를 켜면 다른 모든 기기에서도 그 집중 모드가 켜집니다."
            case .statusOfFocus:
                return "앱에 권한을 허용하면 해당 앱이 집중 모드 중에는 알림 소리가 울리지 않는다는 것을 공유할 수 있습니다."
            }
        }
    }
    
    private let focusModes = [
        FocusMode(title: "방해금지 모드", subTitle: nil, icon: "moon.fill", iconColor: .systemIndigo),
        FocusMode(title: "개인 시간", subTitle: nil, icon: "person.fill", iconColor: .systemPurple),
        FocusMode(title: "수면", subTitle: nil, icon: "bed.double.fill", iconColor: .systemMint),
        FocusMode(title: "업무", subTitle: "설정", icon: "lanyardcard.fill", iconColor: .systemTeal)
    ]
    
    private let shareToAllDevice = [FocusMode(title: "모든 기기에서 공유", subTitle: nil, icon: nil, iconColor: nil)]
    
    private let statusOfFocus = [FocusMode(title: "집중 모드 상태", subTitle: "켬", icon: nil, iconColor: nil)]
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        return collectionView
    }()
    private var dataSource: UICollectionViewDiffableDataSource<SectionType, FocusMode>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, FocusMode>()
        snapshot.appendSections(SectionType.allCases)
        snapshot.appendItems(focusModes, toSection: .modeSettings)
        snapshot.appendItems(shareToAllDevice, toSection: .shareToAllDevices)
        snapshot.appendItems(statusOfFocus, toSection: .statusOfFocus)
        dataSource.apply(snapshot)
    }
    
    private func configureHierarchy() {
        view.backgroundColor = .systemBackground
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.footerMode = .supplementary
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        let footerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionFooter) { footerView, elementKind, indexPath in
            
            let footerItem = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            
            var configuration = footerView.defaultContentConfiguration()
            configuration.text = footerItem.footer
            
            footerView.contentConfiguration = configuration
        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, FocusMode> { cell, indexPath, itemIdentifier in
            
            switch indexPath.section {
            case 0, 2:
                var content = UIListContentConfiguration.valueCell()
                content.text = itemIdentifier.title
                content.secondaryText = itemIdentifier.subTitle
                
                if let systemName = itemIdentifier.icon {
                    content.image = UIImage(systemName: systemName)
                }
                
                content.textProperties.font = .preferredFont(forTextStyle: .body)
                content.secondaryTextProperties.font = .preferredFont(forTextStyle: .body)
                content.imageProperties.tintColor = itemIdentifier.iconColor
                
                cell.contentConfiguration = content
                cell.accessories = [.disclosureIndicator()]
            case 1:
                var content = UIListContentConfiguration.valueCell()
                content.text = itemIdentifier.title
                cell.contentConfiguration = content
                
                let accessoryConfig = UICellAccessory.CustomViewConfiguration(customView: UISwitch(), placement: .trailing())
                cell.accessories = [.customView(configuration: accessoryConfig)]
            default:
                break
            }
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (collectionView, elementKind, indexPath) -> UICollectionReusableView in
            return collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: indexPath)
        }
    }
}

