//
//  ViewController.swift
//  MoviewTableView
//
//  Created by Roen White on 2023/07/28.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    let movieStore = MovieStore().movies
    
    var searchKeyword = String()
    var movieData: [Movie] {
        guard searchKeyword.isEmpty == false else { return movieStore }
        return movieStore.filter { $0.title.contains(searchKeyword) }
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        setUI()
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let inputText = searchTextField.text else { return }
        
        let inputKeyword = inputText.replacingOccurrences(of: " ", with: "")
        
        searchKeyword = inputKeyword
        view.endEditing(true)
        movieTableView.reloadData()
    }
    
    @IBAction func tappedReturnKeyInsideTextField(_ sender: UITextField) {
        searchButtonTapped(searchButton)
    }
    
    @IBAction func tappedClearButtonInsideTextField(_ sender: UITextField) {
        if sender.hasText == false {
            searchButtonTapped(searchButton)
        }
    }
    
}

// MARK: UI design code
extension ViewController {
    func setUI() {
        designSearchButton()
        designSearchTextField()
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
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieInfo") as? MovieTableViewCell else { return UITableViewCell() }
        
        let row = movieData[indexPath.row]
        cell.configureCell(for: row)
        cell.setCellUp()
        
        return cell
    }
}
