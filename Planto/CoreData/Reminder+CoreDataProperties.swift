//
//  Reminder+CoreDataProperties.swift
//  Planto
//
//  Created by Manu on 2024-01-13.
//
//

import Foundation
import CoreData
import UIKit

extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var image: UIImage?
    @NSManaged public var mark: String?
    @NSManaged public var message: String?
    @NSManaged public var name: String?
    @NSManaged public var time: Date?
    @NSManaged public var amount: String?

}

extension Reminder : Identifiable {

}
