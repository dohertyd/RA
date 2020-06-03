# Ryanair Flight Search App

## App for showing available flights for given search criteria
## Using Ryanair API
## 

### App spec
iOS Deployment Target = 13.0
Compiled and tested using Xcode 11.5.1
Compiled using Swift 5.2
Tested on Iphone XS max 13.4.1

## Overview
The App presents a search form for Ryanair flights, Origin and Destination can be selected from a list retrieved form the Api, the list is searchable, Departure date is selected from a datePicker
The search button sends the query to the server and the flights are displayed in a list.
AlamoFire is used for networking and included via swift package manager

## Architecture
The Architecture is basically MVVM with delegation to viewControllers, Dependency Injection is used for the the VIewModels dependency on Networking
allowing switching in of a different Network provider as needed conforming to dataProvider protocol

### Unit Tests
Although no unit tests are written, the use of dependency injection allows easier mocking of Networking in the ViewModel Layer.
The use of ViewModels also aides the unit testing of the project by seperating concerns.


### Assumptions

### Libraries
Using Swift Package manager for dependencies
Alamofire, ~> 5.2.1 Networking , Handles the GET calls to Ryanair Api

### Given extra Time
Carry out  unit tests
More Input search form validation
Improve UI expierence with spinners to indicate network activity
Improve Cell formatting to include more  data
Allow origin station to be filled in from Phone location









