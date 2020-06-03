//
//  Stations.swift
//  Ryanair
//
//  Created by Derek Doherty on 27/05/2020.
//  Copyright © 2020 Derek Doherty. All rights reserved.
//

import Foundation

public struct Stations: Decodable {
    let stations: [Station]
}

public struct Station: Decodable {
    let code: String
    let name: String
}
