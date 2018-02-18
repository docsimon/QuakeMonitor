//
//  RequestStructure.swift
//  QuakeMonitor
//
//  Created by doc on 18/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

struct RequestData {
    let baseUrl: String
    let path: String?
    let query: [URLQueryItem]?
}
