//
//  Parser.swift
//  QuakeMonitor
//
//  Created by doc on 18/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

typealias JsonHandlerClosure = (Data, EarthquakeModel, EarthquakeClosure?) -> ()

struct Features: Codable {
    let features: [Properties]
}

struct Properties: Codable {
    let properties: Earthquake
}

struct Earthquake: Codable {
    let mag: Double
    let place: String
    let time: Int
    let url: String
}

class Parser {
   static func parseJson(data: Data, delegate: EarthquakeModel, completion: EarthquakeClosure?){
//
//
//    let features: [String:Any]?
//
//    do {
//        features = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]
//    }catch {
//        print("Error")
//        return
//    }
//
//    print(features)
        let jsonDecoder = JSONDecoder()
        var features: Features? = nil
        do {
            features = try jsonDecoder.decode(Features.self, from: data)
        }catch {
            ErrorManager.displayError(errorTitle: Constants.Errors.errorDataTitle, errorMsg: Constants.Errors.errorParsingData, presenting: delegate)
            return
        }
        if let properties = features?.features, let completionClosure = completion {
            completionClosure(properties)
        }else{
            ErrorManager.displayError(errorTitle: Constants.Errors.errorDataTitle, errorMsg: Constants.Errors.errorParsingData, presenting: delegate)
            return
        }
    }
}
