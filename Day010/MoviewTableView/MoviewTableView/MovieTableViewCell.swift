//
//  MovieTableViewCell.swift
//  MoviewTableView
//
//  Created by Roen White on 2023/07/29.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    
    func configureCell(for row: Movie) {
        movieTitleLabel.text = row.title
        releaseDateLabel.text = row.releaseDate
        rateLabel.text = "\(row.rate)"
        runtimeLabel.text = "\(row.runtime)분"
        posterImageView.image = UIImage(named: row.title)
        overviewTextView.text = row.overview
    }
    
    func setCellUp() {
        designCellView()
        designPosterImageView()
        designOverviewTextView()
    }
    
    func designCellView() {
        cellView.layer.cornerRadius = 10
        cellView.layer.borderWidth = 0.5
        cellView.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    func designPosterImageView() {
        posterImageView.layer.cornerRadius = 10
    }
    
    func designOverviewTextView() {
        overviewTextView.textContainer.maximumNumberOfLines = 4
        overviewTextView.textContainer.lineBreakMode = .byTruncatingTail
        overviewTextView.textContainerInset = UIEdgeInsets.zero
    }
}
