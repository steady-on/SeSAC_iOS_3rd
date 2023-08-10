//
//  BeerCollectionViewController.swift
//  FeelLikeBeer
//
//  Created by Roen White on 2023/08/10.
//

import UIKit

class BeerCollectionViewController: UICollectionViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
}
