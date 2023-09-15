//
//  UnsplashPhoto.swift
//  Harunstargram
//
//  Created by Roen White on 2023/09/01.
//

import Foundation

struct UnsplashPhoto: Codable {
    let id: String
    let urls: Link
}

struct Link: Codable {
    let thumb: String
    let full: String
}
