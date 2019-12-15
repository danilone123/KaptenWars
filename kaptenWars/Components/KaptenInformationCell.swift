//
//  KaptenInformationCell.swift
//  kaptenWars
//
//  Created by daniel velasco on 13/12/2019.
//  Copyright © 2019 daniel velasco. All rights reserved.
//

import UIKit

class KaptenInformationCell: UITableViewCell {
    
    @IBOutlet weak var horizontalContainerStack: UIStackView!
    @IBOutlet weak var pilotImageView: UIImageView!
    @IBOutlet fileprivate weak var pilotNameLabel: UILabel!
    @IBOutlet fileprivate weak var dropLabel: UILabel!
    @IBOutlet fileprivate weak var pickLabel: UILabel!
    
    override  func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWithTrip(tripVM: TripViewModel) {
        pilotImageView.image = tripVM.pilotImage
        pilotNameLabel.text = tripVM.pilotName
        dropLabel.text = tripVM.dropOffLocationName
        pickLabel.text = tripVM.pickUpLocationName
    }
    
}
