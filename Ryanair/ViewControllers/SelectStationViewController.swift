//
//  SelectStationViewController.swift
//  Ryanair
//
//  Created by Derek Doherty on 30/05/2020.
//  Copyright © 2020 Derek Doherty. All rights reserved.
//

import UIKit

// MARK: - Delegate Protocol
public protocol SelectStationViewControllerDelegate: class {
    func selectStationViewController(_ viewController: SelectStationViewController, didSelectStationWith name: String, and code: String)
}

// MARK: - Main Class
public class SelectStationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = SelectStationViewModel()
    public weak var delegate: SelectStationViewControllerDelegate?
    private let searchController = UISearchController(searchResultsController: nil)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Stations"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        viewModel.delegate = self
        viewModel.getStations()
    }
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    func filterContentForSearchText(_ searchText: String) {
        viewModel.filteredStations = viewModel.stations.filter { (station: Station) -> Bool in
            return station.name.lowercased().contains(searchText.lowercased()) || station.code.lowercased().contains(searchText.lowercased())
      }
      tableView.reloadData()
    }
}

extension SelectStationViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}

// MARK Delegate
extension SelectStationViewController: SelectStationViewModelDelegate {
    public func selectStationViewModel(_ viewModel: SelectStationViewModel, didReceiveStations: Bool) {
        self.tableView.reloadData()
    }
}

// MARK Datasource
extension SelectStationViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return viewModel.filteredStations.count
        }
        return viewModel.stations.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if let cell = cell as? SelectStationTableViewCell {
            viewModel.configure(cell, row: indexPath.row, isFiltering: isFiltering)
        }
        return cell
    }
}

// MARK TableView Delegate
extension SelectStationViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if isFiltering {
            delegate?.selectStationViewController(self, didSelectStationWith: viewModel.filteredStations[indexPath.row].name, and: viewModel.filteredStations[indexPath.row].code)
        } else {
            delegate?.selectStationViewController(self, didSelectStationWith: viewModel.stations[indexPath.row].name, and: viewModel.stations[indexPath.row].code)
        }
    }
}
