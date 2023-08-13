//
//  TranslationResultData.swift
//  LanguageTranslator
//
//  Created by Roen White on 2023/08/13.
//

import Foundation

struct TranslationData: Codable {
    let message: Message
}

struct Message: Codable {
    let result: Result
    let type, service, version: String

    enum CodingKeys: String, CodingKey {
        case result
        case type = "@type"
        case service = "@service"
        case version = "@version"
    }
}

struct Result: Codable {
    let srcLangType, tarLangType, translatedText, engineType: String
}
