//
//  FlightSearchVCExtensions.swift
//  Ryanair
//
//  Created by Derek Doherty on 02/06/2020.
//  Copyright © 2020 Derek Doherty. All rights reserved.
//

import Foundation

// MARK: SelectStationViewControllerDelegate
extension FlightSearchViewController: SelectStationViewControllerDelegate {
    func selectStationViewController(_ viewController: SelectStationViewController, didSelectStationWith name: String, and code: String) {
        navigationController?.popToViewController(self, animated: true)
        
        switch stationType {
        case .origin:
            viewModel.originName = name
            viewModel.originCode = code
        case .destination:
            viewModel.destinationName = name
            viewModel.destinationCode = code
        }
        configureForm()
    }
}

// MARK: SelectDateViewControllerDelegate
extension FlightSearchViewController: SelectDateViewControllerDelegate {
    func selectDateViewController(_ viewController: SelectDateViewController, didSelectDate date: Date) {
        viewModel.departureDate = date
        configureForm()
    }
}

extension FlightSearchViewController {
    func configureForm() {
        originNameLabel.text = viewModel.originName
        originNameCodeLabel.text = viewModel.originCode
        destinationNameLabel.text = viewModel.destinationName
        destinationCodeLabel.text = viewModel.destinationCode
        
        departureDatelabel.text = viewModel.departureDateString
        
        adultsCountLabel.text = viewModel.adultsText
        teensCountLabel.text = viewModel.teensText
        childrenCountLabel.text = viewModel.childrenText
        
        adultStepper.value = Double(viewModel.adults)
        teenageStepper.value = Double(viewModel.teens)
        childrenStepper.value = Double(viewModel.children)
    }
}
