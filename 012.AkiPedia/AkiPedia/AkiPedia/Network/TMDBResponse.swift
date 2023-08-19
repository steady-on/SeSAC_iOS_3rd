//
//  TMDBResponse.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/19.
//

import Foundation

struct TMDBResponse: Codable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String
}
