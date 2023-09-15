//
//  GenreData.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/21.
//

import Foundation

struct GenreData: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
