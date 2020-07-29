//
//  APITwitterDelegate.swift
//  Tweets
//
//  Created by  Vladyslav Fil on 7/8/19.
//  Copyright © 2019  Vladyslav Fil. All rights reserved.
//

import UIKit

protocol APITwitterDelegate: class {
    func processTweets(tweets: [Tweet])
    func errorHandler(error: Error)
    func errorHandler(errorMessage: String)
}
