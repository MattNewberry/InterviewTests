//
//  NearbyBeaconCell.swift
//  ProximityLab
//
//  Created by Matthew Newberry on 10/23/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

import UIKit

class NearbyBeaconCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var proximityView: BeaconProximityView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        locationLabel.textColor = Colors.blueGrayColor()
    }
    
    var beacon: Beacon? {
        didSet {
            reload()
        }
    }
    
    func reload() {
        nameLabel.text = beacon?.name
        locationLabel.text = beacon?.location?.name
        proximityView.proximity = beacon?.proximity
        proximityView.accuracy = beacon?.distance
    }
}
