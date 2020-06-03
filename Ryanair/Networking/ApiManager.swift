//
//  ApiManager.swift
//  Ryanair
//
//  Created by Derek Doherty on 27/05/2020.
//  Copyright © 2020 Derek Doherty. All rights reserved.
//

import Foundation
import Alamofire

protocol FlightInfoDataProvider {
    func getFlightsForSearch(searchForm: SearchForm, completion: @escaping  (([FlightData], AFError? ) -> ()) )
    func getStations(completion: @escaping (([Station], AFError?) -> ()) )
}

class ApiManager: FlightInfoDataProvider {
    func getFlightsForSearch(searchForm: SearchForm, completion: @escaping  (([FlightData], AFError?) -> ())) {
        AF.request(Router.getFlightsForSearch(searchForm))
            .validate()
            .responseDecodable(of: Journey.self) { response in
                switch response.result {
                case .success(let journey):
                    completion(journey.trips[0].dates, nil)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion([], error)
                }
        }
    }
    
    func getStations(completion: @escaping (([Station], AFError?) -> ())) {
        AF.request(Router.getStations)
            .validate()
            .responseDecodable(of: Stations.self) { response in
                switch response.result {
                case .success(let stations):
                    completion(stations.stations, nil)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion([], error)
                }
        }
    }
}
