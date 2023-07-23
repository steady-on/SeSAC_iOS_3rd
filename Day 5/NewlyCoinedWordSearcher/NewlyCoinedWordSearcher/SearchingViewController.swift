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
    
    @IBOutlet weak var recentSearchWordCollectionView: UICollectionView!
    
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
}
