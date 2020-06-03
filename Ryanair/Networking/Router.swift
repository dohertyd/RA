//
//  Router.swift
//  Ryanair
//
//  Created by Derek Doherty on 27/05/2020.
//  Copyright © 2020 Derek Doherty. All rights reserved.
//

import Foundation
import Alamofire

private struct RouterConstants {
    static let RAStationsListBaseUrl = "https://tripstest.ryanair.com/static/stations.json"
    static let RATripSearchBaseUrl = "https://sit-nativeapps.ryanair.com/api/v4/Availability"
}

public enum Router : URLRequestConvertible {
    
    case getFlightsForSearch(SearchForm)
    case getStations
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .getFlightsForSearch:
            return RouterConstants.RATripSearchBaseUrl
        case .getStations:
            return RouterConstants.RAStationsListBaseUrl
        }
    }
    
    var params: Parameters?{
        switch self {
        case let .getFlightsForSearch(searchForm):
            return ["origin": searchForm.originCode,
                    "destination": searchForm.destinationCode,
                    "dateout": searchForm.departureDateServerString,
                    "datein": "",
                    "flexdaysbeforeout": "3",
                    "flexdaysout": "3",
                    "flexdaysin": "0",
                    "adt": String(searchForm.adults),
                    "teen": String(searchForm.teens),
                    "chd": String(searchForm.children),
                    "roundtrip": "false",
                    "ToUs": "AGREED"]
        case .getStations:
            return [:]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try path.asURL()
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request = try URLEncoding.default.encode(request, with: params)
        
        return request
    }
}
