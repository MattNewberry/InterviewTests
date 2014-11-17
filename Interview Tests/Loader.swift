//
//  Loader.swift
//  Interview Tests
//
//  Created by Matthew Newberry on 11/17/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

struct Loader {
    static func load() {
        
        var delegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        let context = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
        context.parentContext = delegate.managedObjectContext
        
        let path = NSBundle.mainBundle().pathForResource("data", ofType: "json")!
        if let contents = NSData(contentsOfFile: path) {
            var json = SwiftyJSON.JSON(data: contents, options: NSJSONReadingOptions(), error: nil)
            
            for (index: String, subJson: JSON) in json {
                
                context.performBlockAndWait({
                    let location = self.locationFromPayload(context, json: subJson)!
                    let beacon = self.beaconFromPayload(context, json: subJson)!
                    
                    beacon.location = location
                    context.save(nil)
                })
            }
        }
    }
    
    private static func locationFromPayload(context: NSManagedObjectContext, json: JSON) -> Location? {
        var location: Location?
        var request = NSFetchRequest(entityName: "Location")
        request.predicate = NSPredicate(format: "name = %@", json["location_name"].stringValue)
        
        var locationResults = context.executeFetchRequest(request, error: nil)
        
        if let results = locationResults {
            let object = NSEntityDescription.insertNewObjectForEntityForName("Location", inManagedObjectContext: context) as NSManagedObject
            if let newLocation = object as? Location {
                newLocation.name = json["location_name"].stringValue
                context.save(nil)
                
                location = newLocation
            }
        }

        
        return location
    }
    
    private static func beaconFromPayload(context: NSManagedObjectContext, json: JSON) -> Beacon? {
        var beacon: Beacon?
        var request = NSFetchRequest(entityName: "Beacon")
        request.predicate = NSPredicate(format: "id = %@", json["id"].stringValue)
        
        var locationResults = context.executeFetchRequest(request, error: nil)
        
        if let results = locationResults {
            let object = NSEntityDescription.insertNewObjectForEntityForName("Beacon", inManagedObjectContext: context) as NSManagedObject
            if let newBeacon = object as? Beacon {
                newBeacon.name = json["beacon_name"].stringValue
                newBeacon.id = json["id"].intValue
                context.save(nil)
                
                beacon = newBeacon
            }
        }
        
        return beacon
    }
}