//
//  TweetTableViewCell.swift
//  Tweets
//
//  Created by  Vladyslav Fil on 7/30/19.
//  Copyright © 2019  Vladyslav Fil. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var tweet: Tweet? {
        didSet {
            if let t = tweet {
                nameLabel?.text = t.name
                descLabel?.text = t.text
                
                if let d = t.date?.toString() {
                    dateLabel?.text = d
                } else {
                    dateLabel?.text = "No Date"
                }
            }
        }
    }
}
