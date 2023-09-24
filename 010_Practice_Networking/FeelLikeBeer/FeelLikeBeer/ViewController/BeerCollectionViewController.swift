//
//  BeerCollectionViewController.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/08/10.
//

import UIKit

final class BeerCollectionViewController: UICollectionViewController {

    private let viewModel = BeerCollectionViewModel()
    
    @IBOutlet weak private var beerCollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Beer>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beerCollectionView.prefetchDataSource = self
        beerCollectionView.collectionViewLayout = createLayout()
        
        viewModel.request()
        viewModel.beers.bind { [weak self] _ in
            self?.beerCollectionView.reloadData()
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let leadingTopItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(2/3))
            let leadingTopItem = NSCollectionLayoutItem(layoutSize: leadingTopItemSize)
            leadingTopItem.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let leadingBottomGroupItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1.0))
            let leadingBottomGroupItem = NSCollectionLayoutItem(layoutSize: leadingBottomGroupItemSize)
            leadingBottomGroupItem.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let leadingBottomGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/3))
            let leadingBottomGroup = NSCollectionLayoutGroup.horizontal(layoutSize: leadingBottomGroupSize, repeatingSubitem: leadingBottomGroupItem, count: 2)
            
            let leadingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(2/3), heightDimension: .fractionalHeight(1.0))
            let leadingGroup = NSCollectionLayoutGroup.vertical(layoutSize: leadingGroupSize, subitems: [leadingTopItem, leadingBottomGroup])
            
            let trailingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/3))
            let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)
            trailingItem.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
            let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize, repeatingSubitem: trailingItem, count: 3)
            
            let subContainerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/2))
            let topContainerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: subContainerGroupSize, subitems: [leadingGroup, trailingGroup])
            let bottomContainerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: subContainerGroupSize, subitems: [trailingGroup, leadingGroup])
            
            let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: containerGroupSize, subitems: [topContainerGroup, bottomContainerGroup])
            
            let section = NSCollectionLayoutSection(group: containerGroup)
            return section
        }
        
        return layout
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeerCollectionViewCell", for: indexPath) as? BeerCollectionViewCell else { return UICollectionViewCell() }
        
        cell.beer = viewModel.cellForItem(at: indexPath)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailBeerController = storyboard?.instantiateViewController(withIdentifier: "DetailBeerViewController") as? DetailBeerViewController else { return }
        detailBeerController.beer = viewModel.cellForItem(at: indexPath)
        navigationController?.pushViewController(detailBeerController, animated: true)
    }
}

extension BeerCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths where viewModel.numberOfCount - 4 == indexPath.item {
            viewModel.requestNextPage()
        }
    }
}
