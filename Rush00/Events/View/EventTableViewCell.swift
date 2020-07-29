//
//  EventTableViewCell.swift
//  Events
//
//  Created by Vladyslav FIL on 10/6/19.
//  Copyright © 2019 Vladyslav FIL. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var maxSubscribersLabel: UILabel!
    @IBOutlet weak var actualSubscribersLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var beginTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    @IBOutlet weak var kindLabel: UILabel!
    
    var event: DecodableEvent? {
        didSet {
            if let e = event {
                nameLabel?.text = e.name
                descriptionLabel?.text = e.description
                maxSubscribersLabel?.text = String(e.maxSubscribers)
                actualSubscribersLabel?.text = String(e.actualNumberOfSubscribers)
                locationLabel?.text = e.location
                //durationLabel?.text = e.endTime - e.beginTime
                beginTimeLabel?.text = e.beginTime//.toDate()?.toString()
                endTimeLabel?.text = e.endTime//.toDate()?.toString()
                kindLabel?.text = e.kind
                
//                let formatter = DateFormatter()
//                formatter.dateFormat = "yyyy/MM/dd HH:mm"
//                dateLabel?.text = formatter.string(from: p.date!)
            }
        }
    }
}

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter.string(from: self)
    }
}

extension String {
    func toDate()-> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-ddTHH:mm:ssZ"
        return formatter.date(from: self)
    }
}
