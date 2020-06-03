//
//  FlightSearchViewModel.swift
//  Ryanair
//
//  Created by Derek Doherty on 28/05/2020.
//  Copyright © 2020 Derek Doherty. All rights reserved.
//

import Foundation

public class FlightSearchViewModel {
    
    // This is our Search Model
    public var searchForm: SearchForm = SearchForm()
    
    // MARK: - Data transformations where needed
    public var originName: String {
        get {
            return searchForm.originName
        }
        set(newValue) {
            searchForm.originName = newValue
        }
    }
    public var originCode: String {
        get {
            return searchForm.originCode
        }
        set(newValue) {
            searchForm.originCode = newValue
        }
    }
    
    public var destinationName: String {
        get {
            return searchForm.destinationName
        }
        set(newValue) {
            searchForm.destinationName = newValue
        }
    }
    public var destinationCode: String {
        get {
            return searchForm.destinationCode
        }
        set(newValue) {
            searchForm.destinationCode = newValue
        }
    }
    
    public var departureDate: Date {
        get {
            return searchForm.departureDate
        }
        set(newValue) {
            searchForm.departureDate = newValue
            
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM, yyyy"
            departureDateString = dateFormatter.string(from: newValue)
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            searchForm.departureDateServerString = dateFormatter.string(from: newValue)
        }
    }
    
    public var departureDateString: String {
        get {
            return searchForm.departureDateString
        }
        set(newValue) {
            searchForm.departureDateString = newValue
        }
    }
    
    public var adultsText: String {
        return "Adults: \(searchForm.adults)"
    }
    public var teensText: String {
        return "Teens: \(searchForm.teens)"
    }
    public var childrenText: String {
        return "Children: \(searchForm.children)"
    }
    
    public var adults: Int {
        get {
            return searchForm.adults
        }
        set (newValue) {
            searchForm.adults = newValue
        }
    }
    public var teens: Int {
        get {
            return searchForm.teens
        }
        set (newValue) {
            searchForm.teens = newValue
        }
    }
    public var children: Int {
        get {
            return searchForm.children
        }
        set (newValue) {
            searchForm.children = newValue
        }
    }
}
