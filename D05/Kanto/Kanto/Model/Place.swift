//
//  Place.swift
//  Kanto
//
//  Created by  Vladyslav Fil on 9/19/19.
//  Copyright © 2019  Vladyslav Fil. All rights reserved.
//

import UIKit
import Foundation
import MapKit

enum CountryCode {
    case ua
    case fr
    case us
}

class Place: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    let countryCode: CountryCode
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D, countryCode: CountryCode)  {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.countryCode = countryCode
        super.init()
    }
}
