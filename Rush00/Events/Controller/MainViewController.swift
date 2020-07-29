//
//  MainViewController.swift
//  Events
//
//  Created by Vladyslav FIL on 10/5/19.
//  Copyright © 2019 Vladyslav FIL. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var cursus42Label: UILabel!
    @IBOutlet weak var cursusCLabel: UILabel!
    
    override func viewDidLoad() {
        print("Token = \(accessToken)")
        getUserData()
    }
    

    func getUserData() {
        let request = NSMutableURLRequest(url : URL(string: "https://api.intra.42.fr/v2/me")!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if error != nil {
                print("Error")
            }
            else if data != nil {
                do {
                    let dic: NSDictionary = try (JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary)!
                    let firstName = dic["first_name"]!
                    let lastName = dic["last_name"]!
                    let login = dic["login"]!
                    let photo = dic["image_url"]!
                    let cursuses = dic["cursus_users"] as! [NSDictionary]
                    if let campus = dic["campus"] as? [NSDictionary] {
                        campusId = campus[0]["id"] as! Int
                    }
                    var cursus42Level: Double!
                    var cursusCLevel: Double!
                    
                    for item in cursuses {
                        if let cursus = item["cursus"] as? NSDictionary {
                            if cursus["name"] as! String == "42" {
                                cursus42Level = (item["level"] as! Double)
                                cursusId = cursus["id"] as! Int
                            }
                            else if cursus["name"] as! String == "Piscine C" {
                                cursusCLevel = (item["level"] as! Double)
                            }
                        }
                    }
                    
                    print("firstName = \(firstName)")
                    print("lastName = \(lastName)")
                    print("login = \(login)")
                    print("photo = \(photo)")
                    print("cursus42Level = \(cursus42Level!)")
                    print("cursusCLevel = \(cursusCLevel!)")
                    print("campusId = \(campusId)")
                    print("cursusId = \(cursusId)")
                    
                    DispatchQueue.main.async {
                        self.firstNameLabel.text = (firstName as! String)
                        self.lastNameLabel.text = (lastName as! String)
                        self.loginLabel.text = (login as! String)
                        self.cursus42Label.text = String(cursus42Level)
                        self.cursusCLabel.text = String(cursusCLevel)
                        
                        let url: URL = URL(string: photo as! String)!
                        if let data = try? Data(contentsOf: url) {
                            if let image = UIImage(data: data) {
                                self.activityIndicator.hidesWhenStopped = true
                                self.activityIndicator.stopAnimating()
                                self.imageView.image = image
                            }
                        //navigationController?.popViewController(animated: true)
                        }
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
