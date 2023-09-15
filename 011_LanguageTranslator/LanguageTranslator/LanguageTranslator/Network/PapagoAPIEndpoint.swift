//
//  NaverAPIEndpoint.swift
//  LanguageTranslator
//
//  Created by Roen White on 2023/08/13.
//

import Foundation

enum PapagoAPIEndpoint {
    case translate
    case detectLangs
    
    private static let baseURL = "https://openapi.naver.com/v1/papago/"
    
    private var endPoint: String {
        switch self {
        case .translate: return "n2mt"
        case .detectLangs: return "detectLangs"
        }
    }
    
    var requestURL: String { PapagoAPIEndpoint.baseURL + self.endPoint }
}
