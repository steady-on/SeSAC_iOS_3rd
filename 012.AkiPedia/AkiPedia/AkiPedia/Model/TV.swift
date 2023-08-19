//
//  TV.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/18.
//

import Foundation

struct TV: MediaProtocol {
    let id: Int
    let name: String
    let originalName, originalLanguage: String
    let originCountry: [String]
    let firstAirDate: String
    let genreIDs: [Int]
    let backdropPath, posterPath: String
    let popularity: Double
    let adult: Bool
    let voteCount: Int
    let voteAverage: Double
    let overview: String
    
    init(data: Result) {
        guard let name = data.name, let originalName = data.originalName,
                let originCountry = data.originCountry, let firstAirDate = data.firstAirDate
        else { return }
        
        self.id = data.id
        self.name = name
        self.originalName = originalName
        self.originalLanguage = data.originalLanguage
        self.originCountry = originCountry
        self.firstAirDate = firstAirDate
        self.genreIDs = data.genreIDS
        self.backdropPath = data.backdropPath
        self.posterPath = data.posterPath
        self.popularity = data.popularity
        self.adult = data.adult
        self.voteCount = data.voteCount
        self.voteAverage = data.voteAverage
        self.overview = data.overview
    }
}
