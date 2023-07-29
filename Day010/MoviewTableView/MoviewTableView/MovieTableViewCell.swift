//
//  MovieTableViewCell.swift
//  MoviewTableView
//
//  Created by Roen White on 2023/07/29.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewLabel: UILabel!
    
    func configureCell(for row: Movie) {
        movieTitleLabel.text = row.title
        releaseDateLabel.text = row.releaseDate
        rateLabel.text = "\(row.rate)"
        runtimeLabel.text = "\(row.runtime)분"
        posterImageView.image = UIImage(named: row.title)
        overviewLabel.text = row.overview
    }
}
