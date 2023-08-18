//
//  TMDBAPINetworkError.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/18.
//

import Foundation

enum TMDBAPINetworkError: Error, CustomDebugStringConvertible {
    case TMDBServerError
    case requestError
    case dataParsingError
    
    var debugDescription: String {
        switch self {
        case .TMDBServerError: return "서버에 문제가 생겼습니다."
        case .requestError: return "잘못된 요청입니다."
        case .dataParsingError: return "유효하지 않은 데이터입니다."
        }
    }
}
