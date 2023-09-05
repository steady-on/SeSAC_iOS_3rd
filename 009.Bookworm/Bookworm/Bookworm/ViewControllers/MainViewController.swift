//
//  ViewController.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    let realm = try! Realm()

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
                
        let item = myBookShelf[indexPath.item]
        cell.configureBookCell(for: item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailViewController = detailViewStoryboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        
        let item = myBookShelf[indexPath.item]
        detailViewController.myBook = item
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        guard let indexPath = indexPaths.first else { return nil }
        
        let selectedBook = myBookShelf[indexPath.row]
        
        let contextMenuConfig = UIContextMenuConfiguration(previewProvider: nil) { _ in
            let bookmarkMenuTitle = selectedBook.isBookmark ? "북마크 해제" : "북마크 하기"
            let bookmarkMenuImage = UIImage(systemName: selectedBook.isBookmark ? "bookmark.slash.fill" : "bookmark.fill")
            
            let bookmark = UIAction(title: bookmarkMenuTitle, image: bookmarkMenuImage) { _ in
                do {
                    try self.realm.write {
                        selectedBook.isBookmark.toggle()
                    }
                    collectionView.reloadData()
                } catch {
                    print(error)
                }
            }
            
            let delete = UIAction(title: "삭제", image: UIImage(systemName: "trash"), attributes: .destructive) { _ in
                
                do {
                    try self.realm.write {
                        self.realm.delete(selectedBook)
                    }
                    collectionView.reloadData()
                } catch {
                    print(error)
                }                
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
        
        bookTableView.rowHeight = 144
        bookTableView.register(BWTableViewCell.self, forCellReuseIdentifier: BWTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBookShelf.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = bookTableView.dequeueReusableCell(withIdentifier: BWTableViewCell.identifier) as? BWTableViewCell else { return UITableViewCell() }
        
        let data = myBookShelf[indexPath.row]
        cell.myBook = data
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let selectedBook = myBookShelf[indexPath.row]
        
        let delete = UIContextualAction(style: .destructive, title: nil) { _, _, _ in
            do {
                try self.realm.write {
                    self.realm.delete(selectedBook)
                }
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
        delete.image = UIImage(systemName: "trash")
        
        let trailingSwipeActions = UISwipeActionsConfiguration(actions: [delete])
        return trailingSwipeActions
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let selectedBook = myBookShelf[indexPath.row]
        
        let bookmark = UIContextualAction(style: .normal, title: nil) { _, _, _ in
            do {
                try self.realm.write {
                    selectedBook.isBookmark.toggle()
                }
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
        
        bookmark.image = localBookData[indexPath.row].isBookmark ? UIImage(systemName: "bookmark.slash.fill") : UIImage(systemName: "bookmark.fill")
        bookmark.backgroundColor = localBookData[indexPath.row].isBookmark ? .systemGray : .systemRed
        
        let leadingSwipeActions = UISwipeActionsConfiguration(actions: [bookmark])
        return leadingSwipeActions
    }
}
