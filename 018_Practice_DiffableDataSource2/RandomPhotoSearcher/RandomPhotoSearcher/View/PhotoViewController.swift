//
//  PhotoCollectionViewController.swift
//  RandomPhotoSearcher
//
//  Created by Roen White on 2023/09/19.
//

import UIKit

class PhotoViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        return collectionView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.clearButtonMode = .always
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        return searchBar
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, UnsplashPhoto>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureHierarchy()
        configureDataSource()
        
        
    }
    
    private func configureNavigationBar() {
        navigationItem.titleView = searchBar
    }
    
    private func configureHierarchy() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, UnsplashPhoto> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.cell()
            content.text = itemIdentifier.location?.name
            content.secondaryText = itemIdentifier.description
            
            content.imageProperties.cornerRadius = 15
            content.imageProperties.maximumSize = .init(width: 120, height: 80)
            DispatchQueue.global().async {
                if let url = URL(string: itemIdentifier.urls.thumb), let data = try? Data(contentsOf: url) {
                    content.image = UIImage(data: data)
                    cell.contentConfiguration = content
                }
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
    
    private func updateSnapshot(for data: [UnsplashPhoto]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, UnsplashPhoto>()
        snapshot.appendSections([0])
        snapshot.appendItems(data)
        dataSource.apply(snapshot)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let content = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: content)
        return layout
    }
}

extension PhotoViewController: UISearchBarDelegate {
    
}
