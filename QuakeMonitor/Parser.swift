//
//  Parser.swift
//  QuakeMonitor
//
//  Created by doc on 18/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

typealias JsonHandlerClosure = (Data, @escaping EarthquakeClosure) -> ()

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
   static func parseJson(data: Data, completion: @escaping EarthquakeClosure){
        let jsonDecoder = JSONDecoder()
        var features: Features? = nil
        do {
            features = try jsonDecoder.decode(Features.self, from: data)
        }catch {
            let errorData = ErrorData(errorTitle: Constants.Errors.errorDataTitle, errorMsg: Constants.Errors.errorParsingData)
            completion(nil, errorData)
            return
        }
        if let properties = features?.features {
            completion(properties, nil)
        }else{
            let errorData = ErrorData(errorTitle: Constants.Errors.errorDataTitle, errorMsg: Constants.Errors.errorParsingData)
            completion(nil, errorData)
            return
        }
    }
}
