//
//  EventsViewController.swift
//  Events
//
//  Created by Vladyslav FIL on 10/6/19.
//  Copyright © 2019 Vladyslav FIL. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let reuseCellIdentifier = "eventCellIdentifier"
    var allEventsData: [DecodableEvent] = []
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getEventsData()
        // Do any additional setup after loading the view.
    }
//
    func getEventsData() {
        let request = NSMutableURLRequest(url : URL(string: "https://api.intra.42.fr/v2/campus/\(campusId)/cursus/\(cursusId)/events?filter[future]=true")!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) in
            if error != nil {
                print("Error")
            }
            else if data != nil {
                do {
                    let decoder = JSONDecoder()
                    self.allEventsData = try decoder.decode([DecodableEvent].self, from: data!)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                catch (let err) {
                    print(err.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allEventsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier, for: indexPath) as! EventTableViewCell
        cell.event = self.allEventsData[indexPath.row]
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
