//
//  Case2ViewController.swift
//  PracticeDiffableDataSource
//
//  Created by Roen White on 2023/09/16.
//

import UIKit

class Case2ViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        return collectionView
    }()
    private var dataSource: UICollectionViewDiffableDataSource<Case2SectionType, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
        
        var snapshot = NSDiffableDataSourceSnapshot<Case2SectionType, String>()
        snapshot.appendSections(Case2SectionType.allCases)
        snapshot.appendItems(Case2SectionType.menuOfTotalSetUp, toSection: .totalSetUp)
        snapshot.appendItems(Case2SectionType.menuOfPersonalSetUp, toSection: .personalSetUp)
        snapshot.appendItems(Case2SectionType.menuOfEtc, toSection: .etc)
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
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.headerMode = .supplementary
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        let headerRegistration = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) { headerView, elementKind, indexPath in
            
            let headerItem = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            
            var headerConfig = headerView.defaultContentConfiguration()
            headerConfig.text = headerItem.title
            headerConfig.textProperties.font = .preferredFont(forTextStyle: .callout)
            
            headerView.contentConfiguration = headerConfig
        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.cell()
            content.text = itemIdentifier
            content.textProperties.font = .preferredFont(forTextStyle: .body)
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (collectionView, elementKind, indexPath) -> UICollectionReusableView in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            
        }
    }
}
