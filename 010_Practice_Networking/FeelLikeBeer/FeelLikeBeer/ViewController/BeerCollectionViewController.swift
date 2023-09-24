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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beerCollectionView.prefetchDataSource = self
        configureCollectionViewFlowLayout()
        
        viewModel.request()
        viewModel.beers.bind { [weak self] _ in
            self?.beerCollectionView.reloadData()
        }
    }
    
    private func configureCollectionViewFlowLayout() {
        let layout = UICollectionViewFlowLayout()

        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 3)

        layout.itemSize = CGSize(width: width/2, height: width)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing

        beerCollectionView.collectionViewLayout = layout
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
