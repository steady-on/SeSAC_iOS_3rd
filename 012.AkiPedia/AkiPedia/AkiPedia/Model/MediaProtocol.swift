//
//  MediaProtocel.swift
//  AkiPedia
//
//  Created by Roen White on 2023/08/22.
//

import Foundation

protocol MediaProtocol {
    static var mediaType: MediaType { get }
    static var genreDictionary: [Int:String]? { get set }
    
    var id: Int { get }
    var genres: [String] { get }
    var overview: String { get }
    var originalLanguage: String { get }
    var backdropPath: String { get }
    var posterPath: String { get }
    var popularity: Double { get }
    var voteAverage: Double { get }
    var voteCount: Int { get }
    var adult: Bool { get }
}
