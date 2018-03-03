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
    private let refreshControl = UIRefreshControl()
    let viewModel = EarthquakeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchData()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshEarthquakeData), for: .valueChanged)

    }
    
    @objc func refreshEarthquakeData(){
        viewModel.fetchData()
    }
    func stopRefreshing(){
        refreshControl.endRefreshing()
    }
}

extension EarthquakeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return earthquakeData?.count ?? 0
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
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if let earthquake = earthquakeData?[indexPath.row]
        {
            if let quakeUrl = earthquake.url {
                UIApplication.shared.open(quakeUrl, options: [:], completionHandler: nil)
            }else {
                ErrorManager.displayError(errorTitle: Constants.Errors.urlPageErrorTitle, errorMsg: Constants.Errors.urlPageErrorTitle, presenting: self)
                return
            }
        }
    }
    
}
// Conforming to the ViewModel protocol
extension EarthquakeViewController {
    func updateUIWithEarthquakeData(earthquakes: [EarthquakeData]){
        earthquakeData = earthquakes
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.stopRefreshing()
        }
    }
    
    func displayError(errorData: ErrorData){
        ErrorManager.displayError(errorTitle: errorData.errorTitle, errorMsg: errorData.errorMsg, presenting: self)
    }
}
