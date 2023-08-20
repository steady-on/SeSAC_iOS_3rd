//
//  TMDBEndpoint.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/18.
//

import Foundation

enum TMDBEndpoint {
    
    private static var baseURL = "https://api.themoviedb.org/3"
    
    case genre(mediaType: MediaType)
    case trending(mediaType: MediaType?, timeWindow: TimeWindow = .day) // nil이면 all
    case detail(mediaType: MediaType, id: Int)
    
    private var rawValue: String {
        switch self {
        case .genre: return "genre"
        case .trending: return "trending"
        case .detail: return "detail"
        }
    }
    
    var url: String {
        let addedEndpointURLString = Self.baseURL + "/\(self.rawValue)/"
        
        switch self {
        case .genre(let mediaType):
            return addedEndpointURLString + "\(mediaType.rawValue)/list"
        case .trending(let mediaType, let timeWindow):
            return addedEndpointURLString + "\(mediaType?.rawValue ?? "all")/\(timeWindow.rawValue)"
        case .detail(let mediaType, let id):
            return addedEndpointURLString + "\(mediaType.rawValue)/\(id)"
        }
    }
    
    enum TimeWindow: String {
        case day
        case week
    }
}


