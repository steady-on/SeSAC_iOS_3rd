//
//  ViewController.swift
//  MoviewTableView
//
//  Created by Roen White on 2023/07/28.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    let movieStore = MovieStore().movies
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        setUI()
    }
    
    
}

// MARK: UI design code
extension ViewController {
    func setUI() {
        designSearchButton()
        designSearchButton()
        movieTableView.rowHeight = 230
    }
    
    func designSearchTextField() {
        searchTextField.font = .preferredFont(forTextStyle: .body)
        searchTextField.textAlignment = .left
        searchTextField.placeholder = "영화 제목을 입력해주세요."
        searchTextField.borderStyle = .none
        searchTextField.clearButtonMode = .always
        searchTextField.autocapitalizationType = .none
        searchTextField.autocorrectionType = .no
        searchTextField.returnKeyType = .go
    }
    
    func designSearchButton() {
        searchButton.setTitleColor(.init(named: "AccentColor"), for: .normal)
        
        let buttonImage = UIImage(systemName: "magnifyingglass")
        let symbolConfiguration = UIImage.SymbolConfiguration.init(font: .preferredFont(forTextStyle: .largeTitle))
        buttonImage?.applyingSymbolConfiguration(symbolConfiguration)
        
        searchButton.imageView?.image = buttonImage
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieInfo") as? MovieTableViewCell else { return UITableViewCell() }
        
        let row = movieStore[indexPath.row]
        cell.configureCell(for: row)
        cell.setCellUp()
        
        return cell
    }

}
