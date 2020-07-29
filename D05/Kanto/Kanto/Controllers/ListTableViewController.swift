//
//  ListTableViewController.swift
//  Kanto
//
//  Created by  Vladyslav Fil on 9/14/19.
//  Copyright © 2019  Vladyslav Fil. All rights reserved.
//

import UIKit
import CoreLocation

class ListTableViewController: UITableViewController {

    let locationCellIdentifier: String = "locationCellIdentifier"
    let showPlaceSegueIdentifier: String = "showPlaceSegue"
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("List Table View did load")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfPlaces.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: locationCellIdentifier, for: indexPath) as! LocationTableViewCell
        cell.placeIndex = indexPath.row
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        performSegue(withIdentifier: showPlaceSegueIdentifier, sender: cell)
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showPlaceSegueIdentifier {
            if let cell = sender as? LocationTableViewCell {
                currentLocationIndex = cell.placeIndex!
            }
        }
    }
    

}
