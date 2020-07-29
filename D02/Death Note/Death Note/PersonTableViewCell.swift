//
//  PersonTableViewCell.swift
//  Death Note
//
//  Created by  Vladyslav Fil on 4/22/19.
//  Copyright © 2019  Vladyslav Fil. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var person: Person? {
        didSet {
            if let p = person {
                nameLabel?.text = p.name
                descriptionLabel?.text = p.description
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd HH:mm"
                dateLabel?.text = formatter.string(from: p.date!)
            }
        }
    }

}
