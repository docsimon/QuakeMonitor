//
//  EarthquakeViewModel.swift
//  QuakeMonitor
//
//  Created by doc on 18/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

protocol EarthquakeModel: class {
    func updateUIWithEarthquakeData(earthquakes: [EarthquakeData])
}

struct EarthquakeData {
    let magnitude: String
    let country: String
    let place: String
    let date: String
}

class EarthquakeViewModel {
    weak var delegate: EarthquakeModel?
    var earthquakeDataArray: [EarthquakeData]? {
        didSet {
            if let earthquakeDataArray = earthquakeDataArray {
                delegate?.updateUIWithEarthquakeData(earthquakes: earthquakeDataArray)
            }
        }
    }
    
    func fetchData(){
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "format", value: "geojson"))
        queryItems.append(URLQueryItem(name: "minmag", value: "6"))
        queryItems.append(URLQueryItem(name: "limit", value: "20"))
        let requestData = RequestData(scheme: Constants.Client.scheme, baseUrl: Constants.Client.baseUrl, path: Constants.Client.path, queryItems: queryItems)
        
        if let delegate = delegate {
            let client = Client(controllerDelegate: delegate, urlRequestData: requestData)
            
            client.fetchJsonData(request: requestData, jsonHandler: Parser.parseJson, completion: { earthquakeDictionaryArray in
                self.earthquakeDataArray = self.formatEarthquakeData(data: earthquakeDictionaryArray)
            })
        }else {
            fatalError("Main view controller not set as delegate !!!")
        }
    }
    
    private func formatEarthquakeData(data: [Properties]?) -> [EarthquakeData]?{
        
        if let data = data {
            let formattedData = data.map { property -> EarthquakeData in
                let earthquakeData =  property.properties
                let earthquake = EarthquakeData(magnitude: String(earthquakeData.mag), country: earthquakeData.place, place: earthquakeData.place, date: String(earthquakeData.time))
                
                return earthquake
                
            }
            return formattedData
        }
        
        return nil
    }
}
