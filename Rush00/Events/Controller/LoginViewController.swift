//
//  LoginViewController.swift
//  Events
//
//  Created by Vladyslav FIL on 10/5/19.
//  Copyright © 2019 Vladyslav FIL. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let UID: String = "1b0165755da4bbfabd5f375ffd62cc47802fc281204bedc7e842a8f4ba4ec73e"
    let SECRET: String = "7163ce447428b14977e4bb0074cceeda262b7b5d1d9a552f04858295da4e8dde"
    let redirectURI: String = "rush00"
    var token: String?
    
    @IBAction func loginButton(_ sender: UIButton) {
        let url: URL = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=\(UID)&redirect_uri=\(redirectURI)%3A%2F%2Fevents_callback&response_type=code")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDel = UIApplication.shared.delegate as! AppDelegate
        appDel.srcViewController = self
    }
    
    func getAccessToken(code: String) {
        let params = "grant_type=authorization_code&client_id=\(UID)&client_secret=\(SECRET)&code=\(code)&redirect_uri=\(redirectURI)%3A%2F%2Fevents_callback"
        let urlStr = "https://api.intra.42.fr/oauth/token?\(params)"
        let urlT = URL(string : urlStr)
        let request = NSMutableURLRequest(url : urlT!)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if error != nil {
                print("Error")
            }
            else if data != nil {
                do {
                    let dic: NSDictionary = try (JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary)!
                    guard let token = dic["access_token"] else {
                        print("Access token doesn't found")
                        return
                    }
                    accessToken = (token as? String)!
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "MainViewSegue", sender: self)
                    }
                }
                catch (let err) {
                    print(err.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
