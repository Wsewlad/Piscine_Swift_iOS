//
//  Request.swift
//  Tweets
//
//  Created by  Vladyslav Fil on 8/5/19.
//  Copyright © 2019  Vladyslav Fil. All rights reserved.
//

import Foundation

class Request {
    
    let CUSTOMER_KEY: String = "LbWOR1GRQLbWtCoEDxbI6JHS2"
    let CUSTOMER_SECRET: String = "0OyOihatx2MXoiAqp0T6eKxnEmlPNTjX1GaEBgkuY2CKQycINB"
    let oauthUrl = "https://api.twitter.com/oauth2/token"
    
    func createTokenRequest() -> NSMutableURLRequest {
        print("Creating token request")
        let bearerCredentials = (CUSTOMER_KEY + ":" + CUSTOMER_SECRET).data(using: String.Encoding.utf8)!.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 04))
        let request = NSMutableURLRequest(url: URL(string: oauthUrl)!)
        request.httpMethod = "POST"
        request.setValue("Basic " + bearerCredentials, forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: String.Encoding.utf8)
        
        return request
    }
    
    
    func createSearchRequest(token: String, searchStr: String, tweetsNbr: Int) -> NSMutableURLRequest {
        
        let q: String = searchStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print("Creating search request for: \(q)")
        let searchTweetsUrl = "https://api.twitter.com/1.1/search/tweets.json?q=\(q)&count=\(tweetsNbr)&tweet_mode=extended"
        let request = NSMutableURLRequest(url: URL(string: searchTweetsUrl)!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        return request
    }
}
