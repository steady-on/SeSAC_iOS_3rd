//
//  SearchViewController.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var searchKeyword: String?
    private var filteredData: [Book] {
        guard let searchKeyword, searchKeyword.isEmpty == false else { return bookData }
        return bookData.filter { $0.title.contains(searchKeyword) }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func searchBarReturnTapped() {
        searchKeyword = searchBar.text
        searchTableView.reloadData()
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
        
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        searchTableView.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarReturnTapped()
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell else { return UITableViewCell() }
        
        cell.book = filteredData[indexPath.row]
        cell.configureCell()
        
        return cell
    }
}
