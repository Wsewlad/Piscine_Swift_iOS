//
//  DecodableEvents.swift
//  Events
//
//  Created by Vladyslav FIL on 10/6/19.
//  Copyright © 2019 Vladyslav FIL. All rights reserved.
//

import Foundation

struct DecodableEvent: Decodable {
    let name: String
    let description: String
    let maxSubscribers: Int
    let actualNumberOfSubscribers: Int
    let location: String
    let kind: String
    let beginTime: String
    let endTime: String
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case maxSubscribers = "max_people"
        case actualNumberOfSubscribers = "nbr_subscribers"
        case location = "location"
        case kind = "kind"
        case beginTime = "begin_at"
        case endTime = "end_at"
    }
}
