//
//  SearchingViewController.swift
//  NewlyCoinedWordSearcher
//
//  Created by Roen White on 2023/07/21.
//

import UIKit

class SearchingViewController: UIViewController {
    
    @IBOutlet weak var searchWordTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var buttonStackView: UIStackView!
    

    @IBOutlet weak var searchResultLabel: UILabel!
    
    var newlyCoinedWordDictionary = [
        "알잘딱": "알아서 잘 딱",
        "레게노": "레전드",
        "갑분싸": "갑자기 분위기가 싸해지다",
        "이생망": "이번 생은 망했어",
        "복세편살": "복잡한 세상 편하게 살자",
        "만반잘부": "만나서 반가워 잘 부탁해",
        "많관부": "많은 관심 부탁드려요",
        "좋댓구알": "좋아요 댓글 구독 알림까지",
        "오뱅알": "오늘 방송 알찼다"
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        guard let textFieldInput = searchWordTextField.text,
              textFieldInput.isEmpty == false else { return }
        
        view.endEditing(true)
        
        searchResultLabel.text = searchToDictionary(for: textFieldInput)
    }
    
    @IBAction func inputReturnKeyToTextField(_ sender: UITextField) {
        searchButtonTapped(searchButton)
    }
    
    func searchToDictionary(for keyword: String) -> String {
        guard let meaning = newlyCoinedWordDictionary[keyword] else {
            return "검색 결과가 없습니다."
        }
        
        return meaning
    }
    
    @IBAction func testCollectionView(_ sender: UIButton) {
        guard let randomKeyword = newlyCoinedWordDictionary.keys.randomElement() else { return }
        
        print(randomKeyword)
        
        let newButton = createRecentSearchKeywordButton(for: randomKeyword)
    
        buttonStackView.insertArrangedSubview(newButton, at: 0)
    }
    
    func createRecentSearchKeywordButton(for label: String) -> UIButton {
        let newButton = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.title = label
        config.titlePadding = 5
        config.titleAlignment = .center
        
        config.baseForegroundColor = .black
        config.cornerStyle = .capsule
        config.background.strokeColor = .black
        
        newButton.configuration = config
        
        return newButton
    }
    
//    func manageRecentSearchKeywords(for keyword: String) -> UIButton {
//        let newButton = createRecentSearchKeywordButton(for: keyword)
//
//        if let index = recentSearchKeywords.firstIndex(of: newButton) {
//            let temp = recentSearchKeywords.remove(at: index)
//        }
//
//        recentSearchKeywords.insert(newButton, at: 0)
//
//        if recentSearchKeywords.count > 5 {
//            recentSearchKeywords.removeLast()
//        }
//
//        return newButton
//    }
}
