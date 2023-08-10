//
//  BeerCollectionViewController.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/08/10.
//

import UIKit

class BeerCollectionViewController: UICollectionViewController {

    let beerManager = BeerManager()
    var beers = [Beer]()
    
    @IBOutlet var beerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViewFlowLayout()
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
    
        let beer = beers[indexPath.row]
        
        cell.nameLabel.text = beer.name
        cell.descriptionTextView.text = beer.description
        beer.getBeerImage { image in
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
        }
    
        return cell
    }
}
