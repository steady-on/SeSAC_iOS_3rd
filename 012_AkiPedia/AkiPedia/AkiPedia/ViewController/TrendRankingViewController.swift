//
//  ViewController.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/21.
//

import UIKit

class TrendRankingViewController: UIViewController {
    let tmdbAPIManager = TMDBAPIManager.shared
    var mediaList = [MediaProtocol]()

    @IBOutlet weak var trendRankingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTrendRankingTableView()
        
        tmdbAPIManager.getTrendAllRanking { result in
            self.mediaList = result
            self.trendRankingTableView.reloadData()
        }
    }
}

extension TrendRankingViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTrendRankingTableView() {
        trendRankingTableView.separatorStyle = .none
        
        trendRankingTableView.dataSource = self
        trendRankingTableView.delegate = self
        
        let nib = UINib(nibName: TrendRankingTableViewCell.identifier, bundle: nil)
        trendRankingTableView.register(nib, forCellReuseIdentifier: TrendRankingTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = trendRankingTableView.dequeueReusableCell(withIdentifier: TrendRankingTableViewCell.identifier) as? TrendRankingTableViewCell else { return UITableViewCell() }
        
        cell.media = mediaList[indexPath.item]
        
        return cell
    }
}
