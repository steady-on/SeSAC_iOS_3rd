//
//  ViewController.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var bookCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        let nib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        bookCollectionView.register(nib, forCellWithReuseIdentifier: "BookCollectionViewCell")
        
        setCollectionViewLayout()
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
