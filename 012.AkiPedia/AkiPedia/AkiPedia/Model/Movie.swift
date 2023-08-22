//
//  Movie.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/22.
//

import Foundation

struct Movie: MediaProtocol {
    static let mediaType: MediaType = .movie
    static var genreDictionary: [Int : String]?
    
    /// media protocol property
    let id: Int
    let genres: [String]
    let overview: String
    let originalLanguage: String
    let backdropPath: String
    let posterPath: String
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    let adult: Bool
    
    /// distinct property
    let title, originalTitle: String
    let releaseDate: String
    let video: Bool
}
