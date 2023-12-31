//
//  SearchViewController.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {
    private var searchResults = [Book]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func searchBarReturnTapped() {
        guard let keyword = searchBar.text else { return }
        
        KakaoAPIManager.searchBook(query: keyword) { books in
            guard let books else { return }
            self.searchResults = books
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
    }
    
    private func configureUI() {
        configureSearchBar()
        configureSearchTableView()
        configureNavigationBar()
    }
}

extension SearchViewController {
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.searchTextField.clearButtonMode = .always
    }
    
    private func configureSearchTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.prefetchDataSource = self
        searchTableView.rowHeight = 144
        searchTableView.register(BWTableViewCell.self, forCellReuseIdentifier: BWTableViewCell.identifier)
    }
    
    private func configureNavigationBar() {
        title = "도서 검색"

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
    }
    
    @objc private func closeButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarReturnTapped()
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BWTableViewCell.identifier) as? BWTableViewCell else { return UITableViewCell() }
        
        cell.book = searchResults[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = searchResults[indexPath.row]
        
        DispatchQueue.global().async {
            guard let url = URL(string: selectedBook.thumbnail),
                  let thumbnailData = try? Data(contentsOf: url) else { return }
            
            let book = MyBook(data: selectedBook, thumbnail: thumbnailData)
            
            let realm = try! Realm()
            
            do {
                try realm.write {
                    realm.add(book)
                }
            } catch {
                print(error)
            }
        }
    }
}

extension SearchViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths where indexPath.row == searchResults.count - 2 {
            KakaoAPIManager.nextPageFetch { books in
                guard let books else { return }
                self.searchResults.append(contentsOf: books)
                DispatchQueue.main.async {
                    self.searchTableView.reloadData()
                }
            }
        }
    }
}
