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
    @Persisted var thumbnail: String
    @Persisted var stateOfReading: StateOfReading
    @Persisted var isBookmark: Bool
    
    convenience init(title: String, author: String, introduce: String, thumbnail: String, stateOfReading: StateOfReading = .notYet, isBookmark: Bool = false) {
        self.init()
        
        self.title = title
        self.author = author
        self.introduce = introduce
        self.thumbnail = thumbnail
        self.stateOfReading = stateOfReading
        self.isBookmark = isBookmark
    }
    
    convenience init(data: Book) {
        self.init(title: data.title,
                  author: data.author,
                  introduce: data.introduce,
                  thumbnail: data.thumbnail)
    }
}

