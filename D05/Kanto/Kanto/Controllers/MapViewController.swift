//
//  MapViewController.swift
//  Kanto
//
//  Created by  Vladyslav Fil on 9/14/19.
//  Copyright © 2019  Vladyslav Fil. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func focusOnMyPosition(_ sender: UIButton) {
        if myLocation != nil {
            navigateTo(coordinate: myLocation!.coordinate)
        }
    }
    
    @IBAction func changeMapType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
        }
    }
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Map View did load")
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
            locationManager.startUpdatingLocation()
        }
        
        addAllPlacesToMap()
        mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Map View did appear")
        navigateTo(coordinate: listOfPlaces[currentLocationIndex].coordinate)
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Location Manager extension

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
        case .denied:
            print("denied")
        case .restricted:
            print("restricted")
        case .notDetermined:
            print("notDetermined")
        default:
            print("Unknown")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            myLocation = location
        }
        print("Location updated !")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAutorizationStatus status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse || status == .authorizedAlways) {
            manager.startUpdatingLocation()
        }
    }
}

// MARK: - Map view extension

extension MapViewController {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("viewFor")
        guard let annotation = annotation as? Place else { return nil }
        var color = UIColor.red
        switch annotation.countryCode {
        case .fr:
            color = .blue
        case .ua:
            color = .yellow
        case .us:
            color = .green
        }
        
        let identifier = "marker"
        let view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        
        view.markerTintColor = color
        return view
    }
    
    func navigateTo(coordinate: CLLocationCoordinate2D) {
        
        let regionRadius: CLLocationDistance = 100.0
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(region, animated: true)
    }
    
    func addAllPlacesToMap() {
        mapView.addAnnotations(listOfPlaces)
    }
}
