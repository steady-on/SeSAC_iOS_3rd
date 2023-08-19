//
//  Movie.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/18.
//

import Foundation

struct Movie: MediaProtocol {
    let id: Int
    let title: String
    let originalTitle, originalLanguage: String
    let releaseDate: String
    let genreIDs: [Int]
    let backdropPath, posterPath: String
    let popularity: Double
    let adult: Bool
    let voteCount: Int
    let voteAverage: Double
    let overview: String
    let video: Bool
    
    init(data: Result) {
        guard let title = data.title, let originalTitle = data.originalTitle,
        let releaseDate = data.releaseDate, let video = data.video
        else { return }
        
        self.id = data.id
        self.title = title
        self.originalTitle = originalTitle
        self.originalLanguage = data.originalLanguage
        self.releaseDate = releaseDate
        self.genreIDs = data.genreIDS
        self.backdropPath = data.backdropPath
        self.posterPath = data.posterPath
        self.popularity = data.popularity
        self.adult = data.adult
        self.voteCount = data.voteCount
        self.voteAverage = data.voteAverage
        self.overview = data.overview
        self.video = video
    }
}

