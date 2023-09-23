//
//  BeerCollectionViewController.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/08/10.
//

import UIKit

class BeerCollectionViewController: UICollectionViewController {

    var beers = [Beer]()
    
    @IBOutlet var beerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beerCollectionView.prefetchDataSource = self
        configureCollectionViewFlowLayout()
        
        requestCall()
    }
    
    func requestCall() {
        BeerManager.request(type: [Beer].self, api: .beers) { result in
            switch result {
            case .success(let data):
                self.beers.append(contentsOf: data)
                self.beerCollectionView.reloadData()
            case .failure(let failure):
                print(failure)
            }
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
        
        cell.beer = beers[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailBeerController = storyboard?.instantiateViewController(withIdentifier: "DetailBeerViewController") as? DetailBeerViewController else { return }
        detailBeerController.beer = beers[indexPath.item]
        navigationController?.pushViewController(detailBeerController, animated: true)
    }
}

extension BeerCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if beers.count - 4 == indexPath.item {
                BeerManager.request(type: [Beer].self, api: .nextPage) { result in
                    switch result {
                    case .success(let beers):
                        self.beers.append(contentsOf: beers)
                        self.beerCollectionView.reloadData()
                    case .failure(let failure):
                        print(failure)
                    }
                }
            }
        }
    }
}
