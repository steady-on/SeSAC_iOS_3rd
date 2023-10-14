//
//  BrowseViewController.swift
//  Bookworm
//
//  Created by Roen White on 2023/08/02.
//

import UIKit

class BrowseViewController: UIViewController {
    
    let data = localBookData.shuffled()

    @IBOutlet weak var recentCollectionView: UICollectionView!
    @IBOutlet weak var bestTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        bestTableView.separatorStyle = .none
        configureTableView()
        configureCollectionView()
    }

    func presentDetailView(for book: Book) {
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        
        detailVC.book = book
        detailVC.modalPresentationStyle = .automatic
        
        present(detailVC, animated: true)
    }
}

extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func configureCollectionView() {
        recentCollectionView.delegate = self
        recentCollectionView.dataSource = self
        recentCollectionView.backgroundColor = .secondarySystemGroupedBackground
        recentCollectionView.register(BWCollectionViewCell.self, forCellWithReuseIdentifier: BWCollectionViewCell.identifier)
        setLayoutForCollectionView()
    }
    
    func setLayoutForCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        let height = recentCollectionView.frame.height * 0.9
        layout.itemSize = CGSize(width: height * 3 / 4 , height: height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumInteritemSpacing = 10
        
        recentCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BWCollectionViewCell.identifier, for: indexPath) as? BWCollectionViewCell else { return UICollectionViewCell() }
        
        cell.book = data[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = data[indexPath.row]
        presentDetailView(for: book)
    }
}

extension BrowseViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        bestTableView.dataSource = self
        bestTableView.delegate = self
        bestTableView.register(BWTableViewCell.self, forCellReuseIdentifier: BWTableViewCell.identifier)
        bestTableView.rowHeight = 152
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bestTableView.dequeueReusableCell(withIdentifier: BWTableViewCell.identifier) as? BWTableViewCell else { return UITableViewCell() }

        cell.book = data[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = data.reversed()[indexPath.row]
        presentDetailView(for: book)
    }
}
