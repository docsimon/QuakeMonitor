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
    func displayError(errorData: ErrorData)
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
        queryItems.append(URLQueryItem(name: "minmag", value: "5"))
        queryItems.append(URLQueryItem(name: "limit", value: "20"))
        let requestData = RequestData(scheme: Constants.Client.scheme, baseUrl: Constants.Client.baseUrl, path: Constants.Client.path, queryItems: queryItems)
        
        if let _ = delegate {
            let client = Client(urlRequestData: requestData)
            
            client.fetchJsonData(request: requestData, jsonHandler: Parser.parseJson, completion: { earthquakeDictionaryArray, errorData  in
                
                if let error = errorData {
                    self.delegate?.displayError(errorData: error)
                    return
                }
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
                let countrySplit = earthquakeData.place.split(separator: ",")
                let country: String
                let place: String
                if countrySplit.count > 1 {
                    country = String(countrySplit[1]).trimmingCharacters(in: .whitespacesAndNewlines)
                    place = String(countrySplit[0]).trimmingCharacters(in: .whitespacesAndNewlines)
                    
                }else{
                    country = String(countrySplit[0]).trimmingCharacters(in: .whitespacesAndNewlines)
                    place = country
                }
                let date = Date(timeIntervalSince1970: TimeInterval(earthquakeData.time)/1000)
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                dateFormatter.timeStyle = .long
                let url = URL(string: earthquakeData.url)
               
                let earthquake = EarthquakeData(magnitude: String(earthquakeData.mag), country: country, place: place, date: dateFormatter.string(from: date), url: url)
                
                return earthquake
            }
            return formattedData
        }
        return nil
    }
}
