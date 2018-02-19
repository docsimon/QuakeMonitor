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
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "format", value: "geojson"))
        queryItems.append(URLQueryItem(name: "minmag", value: "6"))
        queryItems.append(URLQueryItem(name: "limit", value: "20"))
        let requestData = RequestData(scheme: Constants.Client.scheme, baseUrl: Constants.Client.baseUrl, path: Constants.Client.path, queryItems: queryItems)
        
        if let delegate = delegate {
            let client = Client(controllerDelegate: delegate, urlRequestData: requestData)
            
            client.fetchJsonData(request: requestData, jsonHandler: Parser.parseJson, completion: { earthquakeDictionaryArray in
                print(earthquakeDictionaryArray)
            })
        }else {
            fatalError("Main view controller not set as delegate !!!")
        }
    }
}
