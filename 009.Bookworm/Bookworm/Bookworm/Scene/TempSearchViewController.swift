//
//  TempSearchViewController.swift
//  Bookworm
//
//  Created by Roen White on 2023/09/04.
//

import UIKit

class TempSearchViewController: BaseViewController {
    
    private var searchResults = [Book]() {
        didSet { searchResultTableView.reloadData() }
    }
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "책제목, 작가 이름을 입력하세요."
        searchBar.searchTextField.clearButtonMode = .always
        return searchBar
    }()
    
    private let firstEntryLabel: UILabel = {
        let label = UILabel()
        label.text = "검색어를 입력하세요."
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorStyle = .none
        tableView.rowHeight = 144
        tableView.register(BWTableViewCell.self, forCellReuseIdentifier: BWTableViewCell.identifier)
        return tableView
    }()
    
    private let emptyResultLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과가 없습니다."
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.hidesWhenStopped = true
        indicatorView.style = .large
        indicatorView.color = .black
        return indicatorView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        view.backgroundColor = .systemGroupedBackground
        
        configureNavigationBar()
        
        let components = [searchBar, firstEntryLabel, emptyResultLabel, searchResultTableView, indicatorView]
        components.forEach { component in
            view.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        searchBar.delegate = self
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.prefetchDataSource = self
        
        emptyResultLabel.isHidden = true
        searchResultTableView.isHidden = true
    }
    
    override func setConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            firstEntryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstEntryLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emptyResultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyResultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            searchResultTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            searchResultTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchResultTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchResultTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func configureNavigationBar() {
        title = "도서 검색"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
    }
    
    @objc private func closeButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension TempSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else { return }
        
        indicatorView.startAnimating()
        firstEntryLabel.isHidden = true
        KakaoAPIManager.searchBook(query: keyword) { books in
            self.searchResults = books ?? []
            
            let isExistResults = !self.searchResults.isEmpty
            
            self.emptyResultLabel.isHidden = isExistResults
            self.searchResultTableView.isHidden = !isExistResults

            self.indicatorView.stopAnimating()
            self.searchResultTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
}

extension TempSearchViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BWTableViewCell.identifier) as? BWTableViewCell else { return UITableViewCell() }
        
        cell.book = searchResults[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailViewController = detailViewStoryboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else { return }
        

        let selectedBook = searchResults[indexPath.row]
        detailViewController.book = selectedBook
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension TempSearchViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths where indexPath.row == searchResults.count - 2 {
            KakaoAPIManager.nextPageFetch { books in
                guard let books else { return }
                self.searchResults.append(contentsOf: books)
            }
        }
    }
}
