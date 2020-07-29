//
//  APIController.swift
//  Tweets
//
//  Created by  Vladyslav Fil on 7/14/19.
//  Copyright © 2019  Vladyslav Fil. All rights reserved.
//

import UIKit
import Foundation

class APIController {

    weak var delegate: APITwitterDelegate?
    let token: String
    let req = Request()
    var tweets: [Tweet] = []
    
    init(delegate: APITwitterDelegate?, token: String) {
        self.delegate = delegate
        self.token = token
    }
    
    func executeSearchRequest(searchString: String, tweetsNbr: Int) {
        let searchReq = req.createSearchRequest(token: self.token, searchStr: searchString, tweetsNbr: tweetsNbr)
        performTaskWith(request: searchReq) {
            data in
            do {
                let decoder = JSONDecoder()
                let allTweetsDada = try decoder.decode(DecodableTweets.self, from: data)
                for status in allTweetsDada.statuses {
                    self.tweets.append(Tweet(name: status.user.name, text: status.fullText, date: status.createdAt.toDate()))
                }
                if self.tweets.count == 0 {
                    self.delegate?.errorHandler(errorMessage: "No tweets found for '\(searchString)'")
                }
                self.delegate?.processTweets(tweets: self.tweets)
            } catch {
                self.delegate?.errorHandler(errorMessage: "Can't decode data...")
            }
        }
    }
    
    func performTaskWith(request: NSMutableURLRequest, completion: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if error != nil {
                self.delegate?.errorHandler(error: error!)
            }
            else if data != nil {
                completion(data!)
            }
        }
        task.resume()
    }
}
