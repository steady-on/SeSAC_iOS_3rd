//
//  MyBook.swift
//  Bookworm
//
//  Created by Roen White on 2023/09/04.
//

import Foundation
import RealmSwift

class MyBook: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var author: String
    @Persisted var introduce: String
    @Persisted var thumbnail: Data
    @Persisted var statusOfReading: StatusOfReading
    @Persisted var isBookmark: Bool
    
    convenience init(title: String, author: String, introduce: String, thumbnail: Data, stateOfReading: StatusOfReading = .notYet, isBookmark: Bool = false) {
        self.init()
        
        self.title = title
        self.author = author
        self.introduce = introduce
        self.thumbnail = thumbnail
        self.statusOfReading = stateOfReading
        self.isBookmark = isBookmark
    }
    
    convenience init(data: Book, thumbnail: Data) {
        self.init(title: data.title,
                  author: data.author,
                  introduce: data.overview,
                  thumbnail: thumbnail)
    }
}

