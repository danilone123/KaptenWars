//
//  kaptenWarsTests.swift
//  kaptenWarsTests
//
//  Created by daniel velasco on 13/12/2019.
//  Copyright © 2019 daniel velasco. All rights reserved.
//

import XCTest
@testable import kaptenWars

class kaptenWarsTests: XCTestCase {
    fileprivate let pilot = Pilot(name: "test", avatar: "static/test.jpg")
    fileprivate let distance = Distance(value: 124, unit: "km")
    fileprivate let pickUp = Location(name: "Cochabamba", picture: "static/test", date: "2017-12-09T14:12:51Z")
    fileprivate let dropOff = Location(name: "Ruanda", picture: "/static/Yoda.png", date: "16:12:51Z")
    
    func testViewModelImages() {
        let trip = Trip(pilot: pilot, distance: distance, duration: 0, pickUp: pickUp, dropOff: dropOff)
        //duration in seconds
        let viewModel  = TripViewModel(trip: trip)
        XCTAssertNil(viewModel.pilotImage)
        XCTAssertNotNil(viewModel.dropOffImage)
        XCTAssertNil(viewModel.pickUpImage)
    }
    
    func testViewModelTime() {
        let trip = Trip(pilot: pilot, distance: distance, duration: 11234, pickUp: pickUp, dropOff: dropOff)
        let viewModel  = TripViewModel(trip: trip)
        XCTAssertNotNil(viewModel.timeDeparture)
        XCTAssert(viewModel.timeArrival == "", "time arrival should be empty")
        XCTAssertNotNil(viewModel.tripDuration)
        XCTAssert(viewModel.tripDuration == "03:07:14", "format time not working")
    }
}
