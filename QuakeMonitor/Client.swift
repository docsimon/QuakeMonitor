//
//  Client.swift
//  QuakeMonitor
//
//  Created by doc on 18/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

/*
 The responsibilities of the following class are:
 - Fetching data from the remote endpoint
 - Building the endpoint request/url and ensuring their validity
 - Managing all the error related to the connection
*/
class Client {
    
    private let controllerDelegate: EarthquakeModel
    private let urlRequestData: RequestData
    
    init(controllerDelegate: EarthquakeModel, urlRequestData: RequestData) {
        self.controllerDelegate = controllerDelegate
        self.urlRequestData = urlRequestData
    }
    
    // Construct a valid URLRequest
    private func buildRequest(urlStruct: RequestData) -> URLRequest?{
        let baseUrl = urlStruct.baseUrl        
        var urlComponents = URLComponents()
        urlComponents.host = baseUrl
        
        if let path = urlStruct.path {
            urlComponents.path = path
        }
        if let query = urlStruct.query {
            urlComponents.queryItems = [URLQueryItem]()
            urlComponents.queryItems = query
        }
        if let url = urlComponents.url {
            let request = URLRequest(url: url)
            return request
        }
        
        return nil
    }
    
    func fetchJsonData(request: RequestData, jsonHandler: (()->())?, completion: (([Earthquake]) -> ())?){
        
       // guard let urlRequest = buildRequest(urlStruct: request) else {
            ErrorManager.displayError(errorTitle: "Generic Error", errorMsg: "Something went wrong", presenting: controllerDelegate)
            return
      //  }
        
      //  print("OK")
    }
}
