//
//  SearchResult.swift
//  VideoSearcher
//
//  Created by Roen White on 2023/08/17.
//

import Foundation

struct SearchResult: Codable {
    let meta: Meta
    let documents: [Document]
}

struct Document: Codable {
    let title: String
    let author: String
    let datetime: String
    let playTime: Int
    let thumbnail: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author, datetime, thumbnail, title, url
        case playTime = "play_time"
    }
}

struct Meta: Codable {
    let isEnd: Bool
    let pageableCount: Int
    let totalCount: Int

    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
