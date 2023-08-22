//
//  Tv.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/22.
//

import Foundation

struct Tv: MediaProtocol {
    static let mediaType: MediaType = .tv
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
    let name, originalName: String
    let firstAirDate: String
    let originCountry: [String]
}
