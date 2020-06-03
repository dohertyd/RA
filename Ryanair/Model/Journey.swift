//
//  Journey.swift
//  Ryanair
//
//  Created by Derek Doherty on 27/05/2020.
//  Copyright © 2020 Derek Doherty. All rights reserved.
//

import Foundation

public struct Journey: Decodable {
    let trips: [Trip]
}

public struct Trip: Decodable {
    let dates: [FlightData]
}

public struct FlightData: Decodable {
    let flights: [Flight]
    let dateOut: String
}

public struct Flight: Decodable {
    let regularFare: RegularFare
    let flightNumber: String
}

public struct RegularFare: Decodable {
    let fares: [Fare]
}

public struct Fare: Decodable {
    let type: String
    let amount: Double
}
