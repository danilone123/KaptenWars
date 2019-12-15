//
//  TripViewModel.swift
//  kaptenWars
//
//  Created by daniel velasco on 13/12/2019.
//  Copyright © 2019 daniel velasco. All rights reserved.
//

import UIKit

//MARK: - ViewModel
class TripViewModel {
    fileprivate let trip: Trip
    fileprivate let calendar: Calendar
    
    init(trip: Trip) {
        self.trip = trip
        self.calendar = Calendar(identifier: .gregorian)
    }
    
    var pilotName: String {
        return trip.pilot.name
    }
    
    var pilotImage: UIImage? {
        return getImage(pathImage: trip.pilot.avatar)
    }
    
    var pickUpImage: UIImage? {
        return getImage(pathImage: trip.pickUp.picture)
    }
    
    var dropOffImage: UIImage? {
        return getImage(pathImage: trip.dropOff.picture)
    }
    
    var dropOffLocationName: String {
        return trip.dropOff.name
    }
    
    var pickUpLocationName: String {
        return trip.pickUp.name
    }
    
    var rating: Int? {
        if let ratingValue = trip.pilot.rating {
            return Int(ratingValue)
        }
        return nil
    }
    
    var timeDeparture: String? {
        return buildLocalDate(dateText: trip.pickUp.date) ?? ""
    }
    
    var timeArrival: String {
        return buildLocalDate(dateText: trip.dropOff.date) ?? ""
    }
    
    var distance: String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.locale = NSLocale.current
        if let distanceValue = currencyFormatter.string(from: NSNumber(value: trip.distance.value)) {
            return distanceValue + " " + trip.distance.unit.uppercased()
        }
        return ""
    }
    
    var tripDuration: String {
        let (h, m, s) = secondsToHoursMinutesSeconds(seconds: trip.duration)
        return String(format: "%02d:%02d:%02d", h, m, s)
    }
    
    fileprivate func getImageName(pathImage: String) -> String? {
        let listPath = pathImage.split(separator: "/")
        if let nameImage = listPath.last {
            return String(nameImage).capitalized
        }
        return nil
    }
    
    fileprivate func getImage(pathImage: String) -> UIImage? {
        if let imageName = getImageName(pathImage: pathImage) {
            return UIImage(named: imageName, in: nil, compatibleWith: nil)
        }
        return nil
    }
}

//MARK: - Time
extension TripViewModel {
    fileprivate func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    fileprivate func buildLocalDate(dateText: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ssZ"
        dateFormatter.calendar = .current
        let dt = dateFormatter.date(from: dateText)
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        if let dtFormat = dt {
            return dateFormatter.string(from: dtFormat)
        }
        return nil
    }
}

