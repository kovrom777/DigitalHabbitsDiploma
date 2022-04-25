//
//  CoreDataStack.swift
//  DiplomaDigitalHabbits
//
//  Created by Роман Ковайкин on 21.11.2021.
//

import Foundation
import CoreData

final class CoreDataStack {
    // MARK: - private variables
    static let shared = CoreDataStack()
    
    let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewRecord")
        container.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("Unable to initialize core data")
            }
        }
        return container
    }()

    // MARK: - Init
    private init () {}
    // MARK: - Read Methods
    public func loadDataForCrypto() -> [Crypto]? {
        let context = container.viewContext
        var dopResult = [Crypto]()
        context.performAndWait {
            let request = NSFetchRequest<Crypto>(entityName: "Crypto")
            request.sortDescriptors = [.init(key: "totalAmount", ascending: true)]
            do {
                let result = try request.execute()
                dopResult = result
            } catch {
                assertionFailure("Error while recieving data \(error.localizedDescription)")
            }
        }
        try? context.save()
        return dopResult
    }
    
    public func loadDataForStocks() -> [Stock]? {
        let context = container.viewContext
        var dopResult = [Stock]()
        context.performAndWait {
            let request = NSFetchRequest<Stock>(entityName: "Stock")
            request.sortDescriptors = [.init(key: "stockCount", ascending: true)]
            do {
                let result = try request.execute()
                dopResult = result
            } catch {
                assertionFailure("Error while recieving data \(error.localizedDescription)")
            }
        }
        try? context.save()
        return dopResult
    }
    
    // MARK: - Write Methods
    public func writeCryptoData(tokenName: String, date: Date, price: Float, totalCount: Int16, onSuccess: @escaping () -> Void) {
        let writeContext = self.container.newBackgroundContext()

        writeContext.performAndWait {
            let crypto = Crypto(context: writeContext)
            crypto.tokenName = tokenName
            crypto.dateOfPurchase = date
            crypto.price = price
            crypto.tokenCount = totalCount
            crypto.totalAmount = price * Float(totalCount)
            do {
                try writeContext.save()
                print("New Token added")
                onSuccess()
            } catch {
                print("Error while adding new record \(error.localizedDescription)")
            }
        }
    }

    public func writeStockData(
        tokenName: String,
        price: Float,
        dateOfPurchase: Date,
        stockCount: Int16,
        onSuccess: () -> ()) {
        let writeContext = self.container.newBackgroundContext()

        writeContext.performAndWait {
            let stock = Stock(context: writeContext)
            stock.stockName = tokenName
            stock.dateOfPurchase = dateOfPurchase
            stock.boughtPrice = price
            stock.stockCount = stockCount
            do {
                try writeContext.save()
                print("New Stock added")
                onSuccess()
            } catch {
                print("Error while adding new record \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Delete methods
    public func deleteStock(stock: Stock, onSuccess: @escaping () -> Void) {
        do {
            container.viewContext.delete(stock)
            try container.viewContext.save()
            onSuccess()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func deleteCrypto(crypto: Crypto, onSuccess: @escaping () -> Void) {
        do {
            container.viewContext.delete(crypto)
            try container.viewContext.save()
            onSuccess()
        } catch {
            print(error.localizedDescription)
        }
    }
}
