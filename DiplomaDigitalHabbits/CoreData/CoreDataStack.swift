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
    
    
    // MARK: - Methods
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
}
