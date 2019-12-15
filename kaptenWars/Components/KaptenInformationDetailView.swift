//
//  KaptenInformationDetailView.swift
//  kaptenWars
//
//  Created by daniel velasco on 14/12/2019.
//  Copyright © 2019 daniel velasco. All rights reserved.
//

import UIKit

class KaptenInformationDetailView: UIView {
    fileprivate struct Constants {
        static let noRating = "USER DIDN'T RATE YET"
        static let marginLeft: CGFloat = 15.0
        static let top: CGFloat = 8.0
        static let fontSize: CGFloat = 15.0
    }
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var distanceValueLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    @IBOutlet weak var departureLabel: UILabel!
    @IBOutlet weak var namePilotLabel: UILabel!
    @IBOutlet weak var departurePlaceLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var distanceTitleLabel: UILabel!
    @IBOutlet weak var arrivalPlaceLabel: UILabel!
    @IBOutlet weak var tripDurationTitleLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pilotTitleLabel: UILabel!
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        departureLabel.text = "Departure"
        arrivalLabel.text = "Arrival"
        tripDurationTitleLabel.text = "Trip Duration"
        distanceTitleLabel.text = "Trip Distance"
        pilotTitleLabel.text = "Pilot Rating"
    }
    
    func configure(with tripVM: TripViewModel) {
        avatarImageView.image = tripVM.pilotImage
        namePilotLabel.text = tripVM.pilotName.uppercased()
        departurePlaceLabel.text = tripVM.pickUpLocationName.uppercased()
        arrivalPlaceLabel.text = tripVM.dropOffLocationName.uppercased()
        departureTimeLabel.text = tripVM.timeDeparture
        arrivalTimeLabel.text = tripVM.timeArrival
        distanceValueLabel.text = tripVM.distance
        timeLabel.text = tripVM.tripDuration
        if let ratingValue = tripVM.rating, ratingValue > 0 {
            addRatingStars(rating: ratingValue)
        } else {
            addLabel()
        }
    }
    
    fileprivate func addRatingStars(rating: Int) {
        let ratingView = RatingStars(frame: CGRect.zero)
        ratingView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ratingView)
        NSLayoutConstraint.activate([
            ratingView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.marginLeft),
            ratingView.topAnchor.constraint(equalTo: pilotTitleLabel.bottomAnchor, constant: Constants.top)        ])
        ratingView.stars = rating
    }
    
    fileprivate func addLabel() {
        let noRatingLabel = UILabel(frame: CGRect.zero)
        noRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        noRatingLabel.text = Constants.noRating
        noRatingLabel.textColor = UIColor.lightGray
        noRatingLabel.textAlignment = .left
        noRatingLabel.numberOfLines = 0
        noRatingLabel.font = UIFont.systemFont(ofSize: Constants.fontSize)
        addSubview(noRatingLabel)
        NSLayoutConstraint.activate([
            noRatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.marginLeft),
                   noRatingLabel.topAnchor.constraint(equalTo: pilotTitleLabel.bottomAnchor, constant: Constants.top)        ])
    }
}

