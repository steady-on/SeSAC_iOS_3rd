//
//  TMDBData.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/18.
//

import Foundation

// MARK: - TMDBData
struct TMDBData: Codable {
    let page: Int
    let totalPages, totalResults: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    // common property
    let id: Int
    let originalLanguage: String
    let genreIDS: [Int]
    let backdropPath, posterPath: String
    let popularity: Double
    let adult: Bool
    let voteCount: Int
    let voteAverage: Double
    let overview, mediaType: String
    
    // movie only property
    let title, originalTitle: String?
    let releaseDate: String?
    let video: Bool?
    
    // tv only property
    let name, originalName: String?
    let firstAirDate: String?
    let originCountry: [String]?
}
