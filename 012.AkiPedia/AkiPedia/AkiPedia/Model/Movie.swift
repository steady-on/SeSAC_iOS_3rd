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
    let genres: [String]
    let backdropPath, posterPath: String
    let popularity: Double
    let adult: Bool
    let voteCount: Int
    let voteAverage: Double
    let overview: String
    let video: Bool
}

