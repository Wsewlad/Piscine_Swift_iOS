//
//  DisplayTweetsTableViewController.swift
//  Tweets
//
//  Created by  Vladyslav Fil on 7/8/19.
//  Copyright © 2019  Vladyslav Fil. All rights reserved.
//

import Foundation
import UIKit

class DisplayTweetsTableViewController: UITableViewController, APITwitterDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    let reuseCellIdentifier = "ReusableTweetCellInedtifier"
    var token: String?
    var myAPIController: APIController?
    var tweets: [Tweet] = []
    var req = Request()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        searchTweets(searchStr: "school 42")
        textField.placeholder = "Search"
        // Do any additional setup after loading the view.
    }
    
    func searchTweets(searchStr: String) {
        if self.token != nil {
            print("Token exists")
            self.myAPIController = APIController(delegate: self, token: self.token!)
            self.myAPIController?.executeSearchRequest(searchString: searchStr, tweetsNbr: 100)
        }
        else {
            print("Getting token...")
            let tokenReq = req.createTokenRequest()
            let task = URLSession.shared.dataTask(with: tokenReq as URLRequest) {
                (data, response, error) in
                if error != nil {
                    self.errorHandler(error: error!)
                }
                else if data != nil {
                    do {
                        let dic: NSDictionary = try (JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary)!
                        
                        guard let access_token = dic["access_token"] else {
                            self.errorHandler(errorMessage: "Access token doesn't found")
                            return
                        }
                        self.token = access_token as? String
                        self.myAPIController = APIController(delegate: self, token: self.token!)
                        self.myAPIController?.executeSearchRequest(searchString: searchStr, tweetsNbr: 100)
                    }
                    catch (let err) {
                        self.errorHandler(error: err)
                    }
                }
            }
            task.resume()
        }
    }

    func processTweets(tweets: [Tweet]) {
        self.tweets = tweets
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print("Tweets updated")
    }
    
    func errorHandler(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func errorHandler(errorMessage: String) {
        let alert = UIAlertController(title: "Oops...", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}



extension DisplayTweetsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier, for: indexPath) as! TweetTableViewCell
        
        cell.tweet = tweets[indexPath.row]
        return cell
    }
}

extension DisplayTweetsTableViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, !text.isEmpty {
            self.searchTweets(searchStr: text)
            tweets.removeAll()
            textField.resignFirstResponder()
        }
        print("Enter pressed")
        return true
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
