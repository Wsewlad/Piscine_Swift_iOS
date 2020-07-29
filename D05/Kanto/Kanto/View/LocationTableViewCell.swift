//
//  LocationTableViewCell.swift
//  Kanto
//
//  Created by  Vladyslav Fil on 9/14/19.
//  Copyright © 2019  Vladyslav Fil. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!

    var placeIndex: Int? {
        didSet {
            if let idx = placeIndex {
                titleLabel?.text = listOfPlaces[idx].title
            }
        }
    }

}
