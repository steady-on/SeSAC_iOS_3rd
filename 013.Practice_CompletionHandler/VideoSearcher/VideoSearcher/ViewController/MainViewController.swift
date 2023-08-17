//
//  ViewController.swift
//  VideoSearcher
//
//  Created by Roen White on 2023/08/17.
//

import UIKit

class MainViewController: UIViewController, ReuseIdentifying {

    private var videos = [Video]() {
        didSet { videoTableView.reloadData() }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var videoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVideoTableView()
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        KakaoAPIManager.search(for: query) { videos in
            DispatchQueue.main.async {
                self.videos = videos
            }
        } errorHandler: { error in
            print(error)
        }
    }
}

