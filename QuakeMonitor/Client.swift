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

typealias EarthquakeClosure = (([Properties]?, ErrorData?) -> ())
class Client {
    
    private let urlRequestData: RequestData
    
    init(urlRequestData: RequestData) {
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
    
    func fetchJsonData(request: RequestData, jsonHandler: JsonHandlerClosure?, completion: @escaping EarthquakeClosure){
        
        guard let urlRequest = buildRequest(urlStruct: request) else {
            let errorData = ErrorData(errorTitle: Constants.Errors.urlRequestErrorTitle, errorMsg: Constants.Errors.urlRequestErrorTitle)
            completion(nil, errorData)
            return
        }
        
        // make the request
      URLSession.shared.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
            
            // error checking
            guard (error == nil) else {
                let errorData = ErrorData(errorTitle: "Generic Error", errorMsg: (error?.localizedDescription) ?? "Error")
                completion(nil, errorData)
                return
                
            }
            // response checking
            if let statusCode = (response as? HTTPURLResponse)?.statusCode{
                guard (self.checkResponseCode(code: statusCode) == true) else {
                    let errorData = ErrorData(errorTitle: "Generic Error", errorMsg: "Status code: \(String(describing: statusCode))")
                    completion(nil, errorData)
                    return
                }
            }else {
                let errorData = ErrorData(errorTitle: "Generic Error", errorMsg: "Status code unknown")
                completion(nil, errorData)
                return
            }
            // data checking
            guard let data = data else {
                let errorData = ErrorData(errorTitle: "Generic Error", errorMsg: "Error receiving data")
                completion(nil, errorData)
                return
            }
                
        if let jsonHandlerClosure = jsonHandler {
            jsonHandlerClosure(data, completion)
        }else {
            let errorData = ErrorData(errorTitle: Constants.Errors.jsonHandlerErrorTitle, errorMsg: Constants.Errors.jsonHandlerErrorMsg)
                completion(nil, errorData)
            return
        }
        
        }).resume()
        
    }
    
   private func checkResponseCode(code: Int) -> Bool {
        let successCode = [200, 201, 202, 203, 204]
        return successCode.contains(code)
    }
}
