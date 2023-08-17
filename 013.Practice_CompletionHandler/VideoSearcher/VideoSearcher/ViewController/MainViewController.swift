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

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func configureVideoTableView() {
        videoTableView.separatorStyle = .none
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
        
        let nib = UINib(nibName: VideoTableViewCell.identifier, bundle: nil)
        videoTableView.register(nib, forCellReuseIdentifier: VideoTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = videoTableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier) as? VideoTableViewCell else { return UITableViewCell() }
        
        cell.video = videos[indexPath.item]
        
        return cell
    }
}
