//
//  Constants.swift
//  QuakeMonitor
//
//  Created by doc on 19/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Urls {
        static let website = "https://earthquake.usgs.gov"
    }
    
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
        static let urlPageErrorTitle = "No url"
        static let urlPageErrorMsg = "No web page availbel for this event"
        static let clientErrorTitle = "Client Error"
        static let networkErrorTitle = "Network Error"
        static let sessionErrorTitle =  "Authentication Failed"
        static let sessionErrorMsg = "Impossible fetching session url"
        static let statusCodeUnknownMsg = "Status code unknown"
        static let errorReceivingData = "Error receiving data"
    }
    
    struct UIViews {
        struct  ErrorView {
            static let dismissButton = "Dismiss"
            static let reloadButton = "Reload"
        }
    }
}
