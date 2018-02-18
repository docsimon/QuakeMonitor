//
//  EarthquakeViewModel.swift
//  QuakeMonitor
//
//  Created by doc on 18/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

protocol EarthquakeModel: class {
    
}

class EarthquakeViewModel {
    weak var delegate: EarthquakeModel?
    
    func fetchData(){
        let requestData = RequestData(baseUrl: "", path: nil, query: nil)
        let client = Client(controllerDelegate: delegate!, urlRequestData: requestData)
        
        client.fetchJsonData(request: requestData, jsonHandler: nil, completion: nil)
    }
}
