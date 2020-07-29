//
//  MapViewController.swift
//  Plan42
//
//  Created by Vladyslav FIL on 10/12/19.
//  Copyright © 2019 Vladyslav FIL. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class MapViewController: UIViewController, MKMapViewDelegate, UISearchBarDelegate {
    
    var what : Int = 0
    
    var From : MKMapItem?
    var Where : MKMapItem?
    var selectedPin: MKPlacemark? = nil
    var first_point : MKPointAnnotation?
    var second_point : MKPointAnnotation?
    var resultSearchController = UISearchController(searchResultsController: nil)
    var myLocation: CLLocation?
    
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func searchButton(_ sender: Any) {
        if (From != nil && Where != nil){
            route(firstCoordinate: From!, secondCoordinate: Where!)
        }
    }
    
    @IBAction func change_map(_ sender: UISegmentedControl) {
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
    
    @IBAction func find_me(_ sender: UIButton) {
        if myLocation != nil {
            navigateTo(coordinate: myLocation!.coordinate)
            From = MKMapItem(placemark: MKPlacemark(coordinate: myLocation!.coordinate))
            startTextField.text = "My Position"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            locationManager.startUpdatingLocation()
        }
        
        startTextField.delegate = self
        destinationTextField.delegate = self
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        locationSearchTable.locationDelegate = self
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController.searchBar
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
    }
    
}
extension MapViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        what = textField.tag
        resultSearchController.searchBar.delegate = self
        present(resultSearchController, animated: true, completion: nil)
    }
    
}

// Location
extension MapViewController: CLLocationManagerDelegate {

    func navigateTo(coordinate: CLLocationCoordinate2D) {
        
        let regionRadius: CLLocationDistance = 100.0
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        resultSearchController.searchBar.text = ""
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            myLocation = location
        }
        print("Location updated !")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse || status == .authorizedAlways) {
            manager.startUpdatingLocation()
        }
    }
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: \(error)")
        return
    }
}

extension MapViewController: LocationDelegate {
    
    func didSelectLocation(item: MKMapItem) {
        let annotation = MKPointAnnotation()
        annotation.title =  item.placemark.title
        annotation.coordinate =  item.placemark.coordinate
        
        if (what == 1)
        {
            startTextField.text = item.placemark.title
            From = item
            if let p  = first_point{
                mapView.removeAnnotation(p)
            }
            first_point = annotation
        }
        else if (what == 2)
        {
            Where = item
            destinationTextField.text = item.placemark.title
            if let p  = second_point {
                mapView.removeAnnotation(p)
            }
            second_point = annotation
        }

        mapView.showAnnotations([annotation], animated: true)
        navigateTo(coordinate: item.placemark.coordinate)
    }
}


// Route
extension MapViewController {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 3.5
        renderer.strokeColor = .magenta
        return renderer
    }
    
    func route(firstCoordinate: MKMapItem,secondCoordinate : MKMapItem)
    {
        mapView.removeOverlays(mapView.overlays)
        if From?.placemark.coordinate.latitude == myLocation!.coordinate.latitude &&
            From?.placemark.coordinate.longitude == myLocation!.coordinate.longitude {
            if let p = first_point {
                mapView.removeAnnotation(p)
            }
        }
        let firstItem = firstCoordinate
        let secondItem = secondCoordinate
        let requst = MKDirections.Request()
        requst.source = firstItem
        requst.destination = secondItem
        requst.transportType = .automobile
        
        let direction = MKDirections(request : requst)
        direction.calculate { (response, error) in
            guard let response = response else {
                NSLog("Error in requesting \(error.debugDescription)")
                return
            }
            if (response.routes.count > 0){
                let route = response.routes.first!
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
                let rect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
    }
}

extension MapViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}


