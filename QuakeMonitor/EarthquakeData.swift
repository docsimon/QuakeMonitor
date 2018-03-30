//
//  EarthquakeData.swift
//  QuakeMonitor
//
//  Created by doc on 18/03/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

struct EarthquakeData {
    let magnitude: String
    let country: String
    let place: String
    let date: String
    let url: URL?
}

struct ErrorData{
    let errorTitle: String
    let errorMsg: String
}
