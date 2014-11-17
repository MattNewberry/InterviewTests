//
//  Beacon.swift
//  Interview Tests
//
//  Created by Matthew Newberry on 11/17/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

import Foundation
import CoreData

class Beacon: NSManagedObject {

    @NSManaged var hexColor: String
    @NSManaged var name: String
    @NSManaged var id: NSNumber
    @NSManaged var location: Location

}
