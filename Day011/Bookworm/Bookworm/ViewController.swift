//
//  ViewController.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UITableViewDelegate {

    @IBOutlet weak var bookCollectionView: UICollectionView!
    @IBOutlet weak var bookTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        let collectionNib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        bookCollectionView.register(collectionNib, forCellWithReuseIdentifier: "BookCollectionViewCell")
        
        setCollectionViewLayout()
        
        bookTableView.delegate = self
        bookTableView.dataSource = self
        
        let tableNib = UINib(nibName: "BookTableViewCell", bundle: nil)
        bookTableView.register(tableNib, forCellReuseIdentifier: "BookTableViewCell")
    }
    
    @IBAction func segmentValueChenged(_ sender: UISegmentedControl) {
        
        mainView.exchangeSubview(at: 1, withSubviewAt: 0)
    }
    
    @IBAction func searchBarButtonTapped(_ sender: UIBarButtonItem) {
        let searchViewStoryboard = UIStoryboard(name: "Main", bundle: nil)

        guard let searchViewController = searchViewStoryboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        
        let navigationController = UINavigationController(rootViewController: searchViewController)

        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
    }
    
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 4)
        
        layout.itemSize = CGSize(width: width/3, height: width/3 * 1.5)
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        bookCollectionView.collectionViewLayout = layout
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = bookCollectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
                
        let row = bookData[indexPath.row]
        cell.configureBookCell(for: row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailViewStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let detailViewController = detailViewStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        detailViewController.book = bookData[indexPath.row]
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bookTableView.dequeueReusableCell(withIdentifier: "BookTableViewCell") as? BookTableViewCell else { return UITableViewCell() }
        
        let row = bookData[indexPath.row]
        cell.configureCell(for: row)
        
        return cell
    }
    
    
}
