//
//  BrowseViewController.swift
//  Bookworm
//
//  Created by Roen White on 2023/08/02.
//

import UIKit

class BrowseViewController: UIViewController {
    
    let data = bookData.shuffled()

    @IBOutlet weak var recentCollectionView: UICollectionView!
    @IBOutlet weak var bestTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
    }

}

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func configureCollectionView() {
        recentCollectionView.delegate = self
        recentCollectionView.dataSource = self
        
        let nib = UINib(nibName: "BrowseCollectionViewCell", bundle: nil)
        recentCollectionView.register(nib, forCellWithReuseIdentifier: "BrowseCollectionViewCell")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = recentCollectionView.dequeueReusableCell(withReuseIdentifier: "BrowseCollectionViewCell", for: indexPath) as? BrowseCollectionViewCell else { return UICollectionViewCell() }
        
        cell.book = data[indexPath.row]
        cell.configureCell()
        
        return cell
    }
}
