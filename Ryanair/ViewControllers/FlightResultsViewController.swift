//
//  FlightResultsViewController.swift
//  Ryanair
//
//  Created by Derek Doherty on 01/06/2020.
//  Copyright © 2020 Derek Doherty. All rights reserved.
//

import UIKit

class FlightResultsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    {
        didSet {
            tableView.tableFooterView = UIView() // Remove unwanted extra cells
        }
    }
    
    var selectedSearchForm: SearchForm!
    var viewmodel = FlightResultsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewmodel.delegate = self
        viewmodel.getFlights(selectedSearchForm)
    }
}

extension FlightResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewmodel.flightDatas.isEmpty ? 0 : viewmodel.flightDatas[0].flights.count
        return viewmodel.flightResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let cell = cell as? FlightResultsTableViewCell {
            viewmodel.configure(cell, row: indexPath.row)
        }
        return cell
    }
}

extension FlightResultsViewController: FlightResultsViewModelDelegate {
    func flightResultsViewModel(_ viewModel: FlightResultsViewModel, didReceiveResults: Bool) {
                self.tableView.reloadData()
    }
}
