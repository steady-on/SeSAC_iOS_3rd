//
//  ViewController.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/21.
//

import UIKit

class TrendRankingViewController: UIViewController {

    @IBOutlet weak var trendRankingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTrendRankingTableView()
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = trendRankingTableView.dequeueReusableCell(withIdentifier: TrendRankingTableViewCell.identifier) as? TrendRankingTableViewCell else { return UITableViewCell() }
        
        cell.backdropImageView.image = UIImage(systemName: "photo")
        cell.titleLabel.text = "나의 행복한 결혼생활, 안녕하세요. 길게 텍스트를 적는다면?"
        cell.overviewTextView.text = "가족에게 학대받던 젊은 여성이 집안의 주선으로 일견 냉혹해 보이는 남성에게 시집을 간다. 로맨틱 판타지 사극"
        cell.genresLabel.text = "#설렘주의 #로맨틱 #로맨스 애니메이션 #역경을 넘어 #일본 작품"
        cell.designMediaTypeLabel(.tv)
        cell.ratingLabel.text = "\(4.5)"
        
        return cell
    }
}
