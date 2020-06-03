//
//  FlightResultsViewModel.swift
//  Ryanair
//
//  Created by Derek Doherty on 01/06/2020.
//  Copyright © 2020 Derek Doherty. All rights reserved.
//

import Foundation

public protocol FlightResultsViewModelDelegate: class  {
    func flightResultsViewModel(_ viewModel: FlightResultsViewModel, didReceiveResults: Bool)
}

public class FlightResultsViewModel {
    public weak var delegate: FlightResultsViewModelDelegate?
    
    private var dataProvider: FlightInfoDataProvider

    public var flightResults: [FlightResult] = []
    private var flightDatas:[FlightData] = [] {
        didSet {
            for fd in flightDatas {
                for fl in fd.flights {
                    flightResults.append(FlightResult(dateOut: fd.dateOut, flightNumber: fl.flightNumber, regularFare: fl.regularFare.fares[0].amount))
                }
            }
        }
    }
    
    init(dataProvider: FlightInfoDataProvider = ApiManager()) {
        self.dataProvider = dataProvider
    }

    func getFlights(_ searchForm: SearchForm) {
        dataProvider.getFlightsForSearch(searchForm: searchForm) { [weak self ] flightDatas, error  in
            guard let self = self else { return }
            self.flightDatas = flightDatas
            self.delegate?.flightResultsViewModel(self, didReceiveResults: self.flightResults.count > 0)
        }
    }
}

extension FlightResultsViewModel {
    public func configure(_ cell: FlightResultsTableViewCell, row: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let datetime = formatter.date(from: flightResults[row].dateOut)

        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM, yyyy"

        cell.dateLabel.text = "Date Out: " + dateFormatter.string(from: datetime ?? Date())
        cell.flightNrLabel.text = "Flight Nr. " + flightResults[row].flightNumber
        cell.regularFareLabel.text = "Fare $" + String(flightResults[row].regularFare)
    }
}
