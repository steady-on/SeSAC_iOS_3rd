//
//  ViewController.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {

    @IBOutlet weak var bookCollectionView: UICollectionView!
    @IBOutlet weak var bookTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    
    var myBookShelf: Results<MyBook>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        myBookShelf = realm.objects(MyBook.self) as Results<MyBook>

        configureCollectionView()
        setInitialTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bookCollectionView.reloadData()
    }
    
    @IBAction func segmentValueChenged(_ sender: UISegmentedControl) {
        mainView.exchangeSubview(at: 1, withSubviewAt: 0)
        
        switch sender.selectedSegmentIndex {
        case 0: bookCollectionView.reloadData()
        case 1: bookTableView.reloadData()
        default: return
        }
    }
    
    @IBAction func searchBarButtonTapped(_ sender: UIBarButtonItem) {
        let searchViewStoryboard = UIStoryboard(name: "Main", bundle: nil)

        guard let searchViewController = searchViewStoryboard.instantiateViewController(withIdentifier: SearchViewController.identifier) as? SearchViewController else { return }
        
        let navigationController = UINavigationController(rootViewController: searchViewController)

        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func configureCollectionView() {
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        let collectionNib = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        bookCollectionView.register(collectionNib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        setCollectionViewLayout()
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myBookShelf.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = bookCollectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
                
        let row = myBookShelf[indexPath.row]
        cell.configureBookCell(for: row)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailViewController = detailViewStoryboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        
        let row = myBookShelf[indexPath.row]
        detailViewController.myBook = row
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        guard let indexPath = indexPaths.first else { return nil }
        
        let selectedBook = myBookShelf[indexPath.row]
        
        let contextMenuConfig = UIContextMenuConfiguration(previewProvider: nil) { _ in
            let bookmarkMenuTitle = selectedBook.isBookmark ? "북마크 해제" : "북마크 하기"
            let bookmarkMenuImage = UIImage(systemName: selectedBook.isBookmark ? "bookmark.slash.fill" : "bookmark.fill")
            
            let bookmark = UIAction(title: bookmarkMenuTitle, image: bookmarkMenuImage) { _ in
                localBookData[indexPath.row].isBookmark.toggle()
                collectionView.reloadData()
            }
            
            let delete = UIAction(title: "삭제", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                localBookData.remove(at: indexPath.row)
                collectionView.reloadData()
            }
            
            return UIMenu(children: [bookmark, delete])
        }
        
        return contextMenuConfig
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func setInitialTableView() {
        bookTableView.delegate = self
        bookTableView.dataSource = self
        
        let tableNib = UINib(nibName: "BookTableViewCell", bundle: nil)
        bookTableView.register(tableNib, forCellReuseIdentifier: "BookTableViewCell")
        bookTableView.rowHeight = 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localBookData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bookTableView.dequeueReusableCell(withIdentifier: "BookTableViewCell") as? BookTableViewCell else { return UITableViewCell() }
        
        let row = localBookData[indexPath.row]
        cell.data = row
        cell.stateOfReadingButton.tag = indexPath.row
        cell.configureCell()
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: nil) { _, _, _ in
            localBookData.remove(at: indexPath.row)
            tableView.reloadData()
        }
        delete.image = UIImage(systemName: "trash")
        
        let trailingSwipeActions = UISwipeActionsConfiguration(actions: [delete])
        return trailingSwipeActions
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let bookmark = UIContextualAction(style: .normal, title: nil) { _, _, _ in
            localBookData[indexPath.row].isBookmark.toggle()
            tableView.reloadData()
        }
        
        bookmark.image = localBookData[indexPath.row].isBookmark ? UIImage(systemName: "bookmark.slash.fill") : UIImage(systemName: "bookmark.fill")
        bookmark.backgroundColor = localBookData[indexPath.row].isBookmark ? .systemGray : .systemRed
        
        let leadingSwipeActions = UISwipeActionsConfiguration(actions: [bookmark])
        return leadingSwipeActions
    }
}
