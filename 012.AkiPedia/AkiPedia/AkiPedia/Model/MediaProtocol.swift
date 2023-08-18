//
//  MediaProtocol.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/18.
//

import Foundation

protocol MediaProtocol {
    var id: Int { get }
    var originalLanguage: String { get }
    var genreIDs: [Int] { get }
    var backdropPath: String { get }
    var posterPath: String { get }
    var popularity: Double { get }
    var adult: Bool { get }
    var voteCount: Int { get }
    var voteAverage: Double { get }
    var overview: String { get }
}

