//
//  EarthquakeViewController.swift
//  QuakeMonitor
//
//  Created by doc on 18/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import UIKit

class EarthquakeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EarthquakeModel {
    
    @IBOutlet weak var tableView: UITableView!
    
    var earthquakeData: [EarthquakeData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = EarthquakeViewModel()
        viewModel.delegate = self
        viewModel.fetchData()
    }
}

extension EarthquakeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return earthquakeData?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? EarthquakeTableViewCell {
            
            if let earthquake = earthquakeData?[indexPath.row] {
            cell.countryLabel.text = earthquake.country
            cell.magnitudeLabel.text = earthquake.magnitude
            cell.placeLabel.text = earthquake.place
            cell.timeLabel.text = earthquake.date
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
// Conforming to the ViewModel protocol
extension EarthquakeViewController {
    func updateUIWithEarthquakeData(earthquakes: [EarthquakeData]){
        earthquakeData = earthquakes
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
