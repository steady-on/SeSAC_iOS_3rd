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
    
    init(data: Result) {
        guard let genreDictionary = Movie.genreDictionary else { return }
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
        self.title = data.title ?? "정보없음"
        self.originalTitle = data.originalTitle ?? "정보없음"
        self.releaseDate = data.releaseDate ?? "정보없음"
        self.video = data.video ?? false
    }
}
