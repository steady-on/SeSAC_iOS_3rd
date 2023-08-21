//
//  MediaType.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/21.
//

import Foundation

enum MediaType: String, Codable {
    case movie
    case tv
    
    var labelText: String {
        switch self {
        case .movie: return self.rawValue.capitalized
        case .tv: return self.rawValue.uppercased()
        }
    }
}
