//
//  ViewController.swift
//  Siri
//
//  Created by Vladyslav FIL on 10/7/19.
//  Copyright © 2019 Vladyslav FIL. All rights reserved.
//

import UIKit
import ForecastIO
import RecastAI
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBAction func makeRequest(_ sender: UIButton) {
        if let text = self.inputTextField.text, !text.isEmpty {
            self.recastAIBot?.textRequest(text, successHandler: setSuccessResponse, failureHandle: setFailureResponse)
        }
    }
    
    var recastAIBot: RecastAIClient?
    var darkSkyBot: DarkSkyClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recastAIBot = RecastAIClient(token: "cad015d393a344ae67395b3055ab91c4", language: "en")
        self.darkSkyBot = DarkSkyClient(apiKey: "01bd9a9eafb3d1d71c307bf67944a47e")
        self.darkSkyBot?.language = .english
    }

    func setSuccessResponse(_ response: Response) {
        if let location = response.get(entity: "location") {
            if let lat = location["lat"] as? CLLocationDegrees, let lng = location["lng"] as? CLLocationDegrees {
                //print for test
                print("Search result for: \(location["formatted"] as! String )")
                
                let myLoc = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                self.darkSkyBot?.getForecast(location: myLoc, completion: { (result) in
                    switch result {
                    case .success(let currentForcast, _):
                        DispatchQueue.main.async {
                            self.responseLabel.text = currentForcast.currently?.summary
                        }
                    case .failure(_):
                        DispatchQueue.main.async {
                            self.responseLabel.text = "Error"
                        }
                    }
                })
                //print for test
                print("lat = \(lat)")
                print("lng = \(lng)")
            }
        }
        else {
            self.responseLabel.text = "Error"
        }
    }
    
    func setFailureResponse(_ error: Error) {
        self.responseLabel.text = "Error"
        //print for test
        print("error = \(error.localizedDescription)")
    }

}

