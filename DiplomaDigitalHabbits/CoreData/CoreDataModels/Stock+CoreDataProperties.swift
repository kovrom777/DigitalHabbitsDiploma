//
//  Stock+CoreDataProperties.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 21.11.2021.
//
//

import Foundation
import CoreData

extension Stock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stock> {
        return NSFetchRequest<Stock>(entityName: "Stock")
    }

    @NSManaged public var stockName: String?
    @NSManaged public var boughtPrice: Float
    @NSManaged public var dateOfPurchase: Date?
    @NSManaged public var stockCount: Int16

}

extension Stock : Identifiable {

}
