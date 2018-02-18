//
//  Parser.swift
//  QuakeMonitor
//
//  Created by doc on 18/02/2018.
//  Copyright © 2018 Simone Barbara. All rights reserved.
//

import Foundation

struct Features: Codable {
    let features: [Earthquake]
}

struct Earthquake: Codable {
    let mag: Double
    let place: String
    let time: Int
    let url: String
}
