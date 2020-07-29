//
//  LocationSearchTable.swift
//  Plan42
//
//  Created by Ihor RUBAN on 10/12/19.
//  Copyright © 2019 Vladyslav FIL. All rights reserved.
//


import UIKit
import MapKit

protocol LocationDelegate {
    func didSelectLocation(item : MKMapItem)
}

class LocationSearchTable : UIViewController {
    var matchingItems:[MKMapItem] = []
    var handleMapSearchDelegate:HandleMapSearch? = nil
    var locationDelegate: LocationDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        
        print("QQQ")
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
}

extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print ("Text : \(String(searchController.searchBar.text!))")
        
        
        let searchBarText = searchController.searchBar.text


        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = searchBarText

        let search = MKLocalSearch(request: request)

        search.start { response, _ in
            guard let response = response else {
                return
            }
            DispatchQueue.main.async {
                self.matchingItems = response.mapItems
                self.tableView.reloadData()
            }
        }
    }
    
}

extension LocationSearchTable : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        if matchingItems.count > 0 {
            let selectedItem = matchingItems[indexPath.row].placemark
            cell.textLabel?.text = selectedItem.name
            cell.detailTextLabel?.text = parseAddress(selectedItem: selectedItem)
        }
        return cell
    }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationDelegate?.didSelectLocation(item: matchingItems[indexPath.row])
        dismiss(animated: true, completion: nil)
    }

}


