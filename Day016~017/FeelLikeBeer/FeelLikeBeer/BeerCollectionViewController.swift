//
//  BeerCollectionViewController.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/08/10.
//

import UIKit

class BeerCollectionViewController: UICollectionViewController {

    var beerManager = BeerManager()
    var beers = [Beer]()
    
    @IBOutlet var beerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beerCollectionView.prefetchDataSource = self
        
//        if let layout = beerCollectionView.collectionViewLayout as? DynamicCollectionViewLayout {
//            layout.delegate = self
//        }
        
//        configureCollectionViewFlowLayout()
        
        requestCall()
        
    }
    
    func requestCall() {
        beerManager.fetchPagingBeerData { beers in
            self.beers.append(contentsOf: beers)
            self.beerCollectionView.reloadData()
        }
    }
    
    func configureCollectionViewFlowLayout() {
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
        return beers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeerCollectionViewCell", for: indexPath) as? BeerCollectionViewCell else { return UICollectionViewCell() }
    
        cell.beer = beers[indexPath.row]
        
        return cell
    }
}

extension BeerCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if beers.count - 4 == indexPath.row {
                beerManager.goToNextPage()
                beerManager.fetchPagingBeerData { beers in
                    self.beers.append(contentsOf: beers)
                    self.beerCollectionView.reloadData()
                }
            }
        }
    }
}

extension BeerCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BeerCollectionViewCell", for: indexPath) as? BeerCollectionViewCell else { return .zero }
        
        let width = (UIScreen.main.bounds.width - 60)/2
        
        let cellSize = cell.sizeFittingWith(cellWidth: width)
        return cellSize
    }
}

//extension BeerCollectionViewController: DynamicCollectionViewLayoutDelegate {
//    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
//
//        return 1
//    }
//}
