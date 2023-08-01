//
//  SearchViewController.swift
//  Bookworm
//
//  Created by Roen White on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate {
    
    private var searchKeyword: String?
    private var filteredData: [Book] {
        guard let searchKeyword else { return bookData }
        return bookData.filter { $0.title.contains(searchKeyword) }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        searchTableView.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
        
        setNavigationThing()
    }
    
    func setNavigationThing() {
        title = "도서 검색"

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
    }
    
    @objc func closeButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
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
