//
//  FlightSearchViewController.swift
//  Ryanair
//
//  Created by Derek Doherty on 27/05/2020.
//  Copyright © 2020 Derek Doherty. All rights reserved.
//

import UIKit

enum StationType: String {
    case origin
    case destination
}

class FlightSearchViewController: UIViewController {
    
    // MARK: - IBOUTLETS
    @IBOutlet weak var originNameLabel: UILabel!
    @IBOutlet weak var originNameCodeLabel: UILabel!
    @IBOutlet weak var destinationNameLabel: UILabel!
    @IBOutlet weak var destinationCodeLabel: UILabel!
    
    @IBOutlet weak var departureDatelabel: UILabel!
    
    @IBOutlet weak var adultsCountLabel: UILabel!
    @IBOutlet weak var teensCountLabel: UILabel!
    @IBOutlet weak var childrenCountLabel: UILabel!
    
    @IBOutlet weak var adultStepper: UIStepper!
    @IBOutlet weak var teenageStepper: UIStepper!
    @IBOutlet weak var childrenStepper: UIStepper!
    
    // MARK: - VIEWMODEL
    var viewModel = FlightSearchViewModel()
    
    var stationType: StationType = .origin
    
    // MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Find Flights"
        configureForm()
    }

    // MARK: IBACTIONS
    
    @IBAction func originTapped(_ sender: UITapGestureRecognizer) {
        stationType = .origin
        performSegue(withIdentifier: "SearchFormToStations", sender: nil)
    }
    @IBAction func destinationTapped(_ sender: UITapGestureRecognizer) {
        stationType = .destination
        performSegue(withIdentifier: "SearchFormToStations", sender: nil)
    }
    @IBAction func departureTapped(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "SearchFormToDate", sender: nil)
    }
    @IBAction func adultsStepperChanged(_ sender: UIStepper) {
        viewModel.adults = Int(sender.value)
        configureForm()
    }
    @IBAction func teenStepperChanged(_ sender: UIStepper) {
        viewModel.teens = Int(sender.value)
        configureForm()
    }
    @IBAction func childrenStepperChanged(_ sender: UIStepper) {
        viewModel.children = Int(sender.value)
        configureForm()
    }

    
    @IBAction func searchTapped(_ sender: Any) {
        performSegue(withIdentifier: "SearchFormToFlightResults", sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchFormToStations" {
            guard let ssvvc = segue.destination as? SelectStationViewController else { return }
            ssvvc.navigationItem.title = stationType.rawValue
            ssvvc.delegate = self
        } else if segue.identifier == "SearchFormToDate" {
            guard let sdvc = segue.destination as? SelectDateViewController else { return }
            sdvc.navigationItem.title = "Select Departure"
            sdvc.delegate = self
        } else if segue.identifier == "SearchFormToFlightResults" {
            guard let frvc = segue.destination as? FlightResultsViewController else { return }
            frvc.navigationItem.title = "Flights"
            frvc.selectedSearchForm = viewModel.searchForm
        }
    }
}



