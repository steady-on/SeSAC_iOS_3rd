//
//  TMDBGenre.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/20.
//

import Foundation

struct TMDBGenre: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
