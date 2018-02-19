//
//  Constants.swift
//  QuakeMonitor
//
//  Created by doc on 19/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Client {
      static let scheme = "https"
      static let baseUrl = "earthquake.usgs.gov"
      static let path = "/fdsnws/event/1/query"
    }
    
    struct Errors {
        static let errorDataTitle = "Data Error"
        static let errorParsingData = "Error parsing data"
        static let jsonHandlerErrorTitle = "Json handler Error"
        static let jsonHandlerErrorMsg = "The Json handler is nil"
        static let urlRequestErrorTitle = "URLRequest Error"
        static let urlRequestErrorMsg = "URLRequest is empty"

        
    }
}
