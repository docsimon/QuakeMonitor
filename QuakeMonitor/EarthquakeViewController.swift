//
//  EarthquakeViewController.swift
//  QuakeMonitor
//
//  Created by doc on 18/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import UIKit

class EarthquakeViewController: UIViewController, EarthquakeModel {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = EarthquakeViewModel()
        viewModel.delegate = self
        viewModel.fetchData()
    }

}

