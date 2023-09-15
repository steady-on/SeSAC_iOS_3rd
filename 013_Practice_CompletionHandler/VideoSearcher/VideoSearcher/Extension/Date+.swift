//
//  Date+.swift
//  VideoSearcher
//
//  Created by Roen White on 2023/08/17.
//

import Foundation

extension Date {
    var relativeTimeToAbbreviated: String {
        let relativeFormatter = RelativeDateTimeFormatter()
        relativeFormatter.unitsStyle = .abbreviated
        return relativeFormatter.localizedString(for: self, relativeTo: Date.now)
    }
}
