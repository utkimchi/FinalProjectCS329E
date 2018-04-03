//
//  Recycler+CoreDataProperties.swift
//  FinalProject
//
//  Created by Avila, Colton C on 3/27/18.
//  Copyright © 2018 Group 12. All rights reserved.
//
//

import Foundation
import CoreData


extension Recycler {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recycler> {
        return NSFetchRequest<Recycler>(entityName: "Recycler")
    }

    @NSManaged public var paperTotal: Int64
    @NSManaged public var plasticTotal: Int64
    @NSManaged public var cardboardTotal: Int64
    @NSManaged public var glassTotal: Int64
    @NSManaged public var metalsTotal: Int64
    @NSManaged public var name: String
    @NSManaged public var pureGarbageTotal: Int64
    @NSManaged public var password: String

}
