//
//  TV.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/18.
//

import Foundation

struct TV {
    let id: Int
    let name, originalName: String
    let originalLanguage: String
    let originCountry: [String]
    let firstAirDate: String
    let genreIDS: [Int]
    let backdropPath, posterPath: String
    let popularity: Double
    let adult: Bool
    let voteCount: Int
    let voteAverage: Double
    let overview, mediaType: String
}
