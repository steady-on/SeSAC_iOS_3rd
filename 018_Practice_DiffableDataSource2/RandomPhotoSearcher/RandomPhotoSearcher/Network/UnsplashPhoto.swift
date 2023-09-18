//
//  UnsplashPhoto.swift
//  RandomPhotoSearcher
//
//  Created by Roen White on 2023/09/19.
//

import Foundation

struct UnsplashPhoto: Codable, Hashable {
    let id: String
    let description: String?
    let location: Location?
    let urls: Link
}

struct Link: Codable, Hashable {
    let thumb: String
    let full: String
}

struct Location: Codable, Hashable {
    let name: String?
}
