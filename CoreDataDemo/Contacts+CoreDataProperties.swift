//
//  Contacts+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Hala on 13/08/2021.
//
//

import Foundation
import CoreData


extension Contacts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contacts> {
        return NSFetchRequest<Contacts>(entityName: "Contacts")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?

}

extension Contacts : Identifiable {

}
