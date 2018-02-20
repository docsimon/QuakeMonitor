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

typealias EarthquakeClosure = (([Properties]?) -> ())
class Client {
    
    private let controllerDelegate: EarthquakeModel
    private let urlRequestData: RequestData
    
    init(controllerDelegate: EarthquakeModel, urlRequestData: RequestData) {
        self.controllerDelegate = controllerDelegate
        self.urlRequestData = urlRequestData
    }
    
    // Construct a valid URLRequest
    private func buildRequest(urlStruct: RequestData) -> URLRequest?{
        var urlComponents = URLComponents()
        urlComponents.scheme = urlStruct.scheme
        urlComponents.host = urlStruct.baseUrl
        
        if let path = urlStruct.path {
            urlComponents.path = path
        }
        if let queryItems = urlStruct.queryItems {
            urlComponents.queryItems = [URLQueryItem]()
            urlComponents.queryItems = queryItems
        }
        
        if let url = urlComponents.url {
            let request = URLRequest(url: url)
            return request
        }
        
        return nil
    }
    
    func fetchJsonData(request: RequestData, jsonHandler: JsonHandlerClosure?, completion: EarthquakeClosure?){
        
        guard let urlRequest = buildRequest(urlStruct: request) else {
            ErrorManager.displayError(errorTitle: Constants.Errors.urlRequestErrorTitle, errorMsg: Constants.Errors.urlRequestErrorTitle, presenting: controllerDelegate)
            return
        }
        
        // make the request
      URLSession.shared.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
            
            // error checking
            guard (error == nil) else {
                
                ErrorManager.displayError(errorTitle: "Generic Error", errorMsg: (error?.localizedDescription) ?? "Error", presenting: self.controllerDelegate)
                return
                
            }
            // response checking
            if let statusCode = (response as? HTTPURLResponse)?.statusCode{
                guard (self.checkResponseCode(code: statusCode) == true) else {
                    ErrorManager.displayError(errorTitle: "Generic Error", errorMsg: "Status code: \(String(describing: statusCode))", presenting: self.controllerDelegate)
                    return
                }
            }else {
                ErrorManager.displayError(errorTitle: "Generic Error", errorMsg: "Status code unknown", presenting: self.controllerDelegate)
                return
            }
            // data checking
            guard let data = data else {
                ErrorManager.displayError(errorTitle: "Generic Error", errorMsg: "Error receiving data", presenting: self.controllerDelegate)
                return
            }
                
        if let jsonHandlerClosure = jsonHandler {
            jsonHandlerClosure(data, self.controllerDelegate, completion)
        }else {
            ErrorManager.displayError(errorTitle: Constants.Errors.jsonHandlerErrorTitle, errorMsg: Constants.Errors.jsonHandlerErrorMsg, presenting: self.controllerDelegate)
            return
        }
        
        }).resume()
        
    }
    
   private func checkResponseCode(code: Int) -> Bool {
        let successCode = [200, 201, 202, 203, 204]
        return successCode.contains(code)
    }
}
