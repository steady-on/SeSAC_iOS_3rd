//
//  AllTrendData.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/21.
//

import Foundation

// MARK: - AllTrendData
struct AllTrendData: Codable {
    let results: [Result]
    let page, totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
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
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
}
