//
//  SelectStationViewModel.swift
//  Ryanair
//
//  Created by Derek Doherty on 30/05/2020.
//  Copyright © 2020 Derek Doherty. All rights reserved.
//

import Foundation

public protocol SelectStationViewModelDelegate: class  {
    func selectStationViewModel(_ viewModel: SelectStationViewModel, didReceiveStations: Bool)
}

public class SelectStationViewModel {
    public weak var delegate: SelectStationViewModelDelegate?
    
    private var dataProvider: FlightInfoDataProvider
    
    public var stations: [Station] = []
    public var filteredStations: [Station] = []
    
    init(dataProvider: FlightInfoDataProvider = ApiManager()) {
        self.dataProvider = dataProvider
    }
    
    func getStations() {
        dataProvider.getStations() { [weak self ] stations, error  in
            guard let self = self else { return }
            self.stations = stations
            self.delegate?.selectStationViewModel(self, didReceiveStations: stations.count > 0)
        }
    }
}

extension SelectStationViewModel {
    public func configure(_ cell: SelectStationTableViewCell, row: Int, isFiltering: Bool) {
        if isFiltering {
            cell.stationNameLabel.text = filteredStations[row].name
            cell.stationCodeLabel.text = filteredStations[row].code
        } else {
            cell.stationNameLabel.text = stations[row].name
            cell.stationCodeLabel.text = stations[row].code
        }
    }
}
