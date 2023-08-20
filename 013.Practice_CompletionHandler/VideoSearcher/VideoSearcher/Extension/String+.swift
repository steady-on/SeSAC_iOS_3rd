//
//  String+.swift
//  VideoSearcher
//
//  Created by Roen White on 2023/08/20.
//

import Foundation

extension String {
    var convertDateFormat: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"  // "2023-08-09T16:45:02.000+09:00"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Korea")
        
        return dateFormatter.date(from: self)?.relativeTimeToAbbreviated
    }
}
