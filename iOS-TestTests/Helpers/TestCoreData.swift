//
//  TestCoreData.swift
//  iOS-TestTests
//
//  Created by Mari Budko on 29.09.2025.
//

import CoreData
@testable import iOS_Test

enum TestCoreData {
    static func makeInMemoryContext(modelName: String = "Model") -> NSManagedObjectContext {
        let container = NSPersistentContainer(name: modelName)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { _, error in
            if let error = error {fatalError("CoreData load error: \(error)")}
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container.viewContext
    }
}
