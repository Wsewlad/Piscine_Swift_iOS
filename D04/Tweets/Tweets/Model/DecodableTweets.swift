//
//  DecodableTweets.swift
//  Tweets
//
//  Created by  Vladyslav Fil on 8/26/19.
//  Copyright © 2019  Vladyslav Fil. All rights reserved.
//

import Foundation

struct DecodableTweets: Decodable {
    struct Status: Decodable {
        struct User: Decodable {
            let name: String
            enum CodingKeys: String, CodingKey {
                case name
            }
        }
        
        let user: User
        let createdAt: String
        let fullText: String
        enum CodingKeys: String, CodingKey {
            case user
            case createdAt = "created_at"
            case fullText = "full_text"
        }
    }
    let statuses: [Status]
    enum CodingKeys: String, CodingKey {
        case statuses
    }
}
