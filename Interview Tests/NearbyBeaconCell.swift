//
//  NearbyBeaconCell.swift
//  ProximityLab
//
//  Created by Matthew Newberry on 10/23/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

import UIKit

struct FibGenerator {
    typealias Element = Int
    var i = 0, j = 0
    mutating func next() -> Int? {
        if (i == 0) {i = 1; return 1}
        if (j == 0) {j = 2; return 2}
        var sum = i + j; i = j; j = sum
        return sum
    }
}

class NearbyBeaconCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    var beacon: Beacon? {
        didSet {
            reload()
        }
    }
    
    override func awakeFromNib() {
        nameLabel.layer.shadowOpacity = 0.5
        nameLabel.layer.shadowRadius = 1
        
        locationLabel.layer.shadowOpacity = 0.5
        locationLabel.layer.shadowRadius = 1
        locationLabel.alpha = 1
    }
    
    func reload() {
        nameLabel.text = beacon?.name.capitalizedString
        locationLabel.text = beacon?.location.name
        numberLabel.text = ""
        
        let number = self.determineNumber()
        self.numberLabel.text = "\(number)"
    }
    
    func determineNumber() -> Int{
        var fib = FibGenerator()
        var sum = 0
        var current : Int = 0
        while current < 40000000 {
            if current % 2 == 0 {sum += current}
            current = fib.next()!
        }
        
        usleep(50000) // 50ms of data crunching
        
        return sum
    }
}
