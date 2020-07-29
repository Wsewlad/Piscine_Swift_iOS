//
//  Data.swift
//  Kanto
//
//  Created by Vladyslav FIL on 10/1/19.
//  Copyright © 2019  Vladyslav Fil. All rights reserved.
//

import Foundation
import CoreLocation

var myLocation: CLLocation?
var currentLocationIndex: Int = 0

let listOfPlaces: [Place] = [
    Place(title: "42",
          subtitle: "Shcool 42 in France",
          coordinate: CLLocationCoordinate2D(latitude: 48.896569, longitude: 2.318499),
          countryCode: .fr
    ),
    Place(title: "UNIT",
          subtitle: "Shcool 42 in Ukraine",
          coordinate: CLLocationCoordinate2D(latitude: 50.468957, longitude: 30.462286),
          countryCode: .ua
    ),
    Place(title: "42 Silicon Valey",
          subtitle: "Shcool 42 in USA",
          coordinate: CLLocationCoordinate2D(latitude: 37.548707, longitude: -122.059140),
          countryCode: .us
    ),
]
