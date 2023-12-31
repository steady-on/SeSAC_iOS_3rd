//
//  Tv.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/22.
//

import Foundation

struct Tv: MediaProtocol {
    let mediaType: MediaType = .tv
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
    
    init?(data: Result) {
        guard let genreDictionary = Tv.genreDictionary else { return nil }
        let genres = data.genreIDS.map { genreDictionary[$0] ?? "" }
        
        self.id = data.id
        self.genres = genres
        self.overview = data.overview
        self.originalLanguage = data.originalLanguage
        self.backdropPath = data.backdropPath
        self.posterPath = data.posterPath
        self.popularity = data.popularity
        self.voteAverage = data.voteAverage
        self.voteCount = data.voteCount
        self.adult = data.adult
        
        /// distinct property
        self.name = data.name ?? "정보없음"
        self.originalName = data.originalName ?? "정보없음"
        self.firstAirDate = data.firstAirDate ?? "정보없음"
        self.originCountry = data.originCountry ?? ["정보없음"]
    }
}
