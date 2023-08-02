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
        
        bestTableView.separatorStyle = .none
        configureTableView()
        configureCollectionView()
        setLayoutForCollectionView()
    }

}

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func configureCollectionView() {
        recentCollectionView.delegate = self
        recentCollectionView.dataSource = self
        
        let nib = UINib(nibName: "BrowseCollectionViewCell", bundle: nil)
        recentCollectionView.register(nib, forCellWithReuseIdentifier: "BrowseCollectionViewCell")
    }
    
    func setLayoutForCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        recentCollectionView.collectionViewLayout = layout
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

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        bestTableView.dataSource = self
        bestTableView.delegate = self
        
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        bestTableView.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bestTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.book = data.reversed()[indexPath.row]
        cell.configureCell()
        
        return cell
    }
}
