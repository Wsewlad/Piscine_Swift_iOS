//
//  Tweet.swift
//  Tweets
//
//  Created by  Vladyslav Fil on 7/8/19.
//  Copyright © 2019  Vladyslav Fil. All rights reserved.
//

import Foundation

struct Tweet: CustomStringConvertible {
    var description: String {
        return "name: \(name)\n text: \(text)\n date: \(String(describing: date?.toString()))"
    }
    
    let name: String
    let text: String
    let date: Date?
}

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: self)
    }
}

extension String {
    func toDate()-> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "E MMM dd HH:mm:ss Z yyyy"
        return formatter.date(from: self)
    }
}
