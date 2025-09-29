//
//  CoreDataStack.swift
//  iOS-Test
//
//  Created by Mari Budko on 29.09.2025.
//

import CoreData

final class CoreDataStack {
    let container: NSPersistentContainer
    
    init(modelName: String = "Model", inMemory: Bool = false) {
        container = NSPersistentContainer(name: modelName)
        if inMemory {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
        } else {
            if let desc = container.persistentStoreDescriptions.first {
                desc.setOption(true as NSNumber, forKey: NSMigratePersistentStoresAutomaticallyOption)
                desc.setOption(true as NSNumber, forKey: NSInferMappingModelAutomaticallyOption)
            }
        }
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData load error: \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    var viewContext: NSManagedObjectContext { container.viewContext }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
}
