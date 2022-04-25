//
//  Crypto+CoreDataProperties.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 21.11.2021.
//
//

import Foundation
import CoreData


extension Crypto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Crypto> {
        return NSFetchRequest<Crypto>(entityName: "Crypto")
    }

    @NSManaged public var tokenName: String?
    @NSManaged public var dateOfPurchase: Date?
    @NSManaged public var price: Float
    @NSManaged public var tokenCount: Int16
    @NSManaged public var totalAmount: Float

}

extension Crypto : Identifiable {

}
