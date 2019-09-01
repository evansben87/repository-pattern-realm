//
//  CoreDataRepository.swift
//  RepositoryPatternRealm
//
//  Created by Kristijan Kralj on 31/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation
import CoreData

class CoreDataRepository<RepositoryObject>: Repository
        where RepositoryObject: Entity,
        RepositoryObject.StoreType: NSManagedObject,
        RepositoryObject.StoreType.EntityObject == RepositoryObject {
    // MARK: - Core Data stack
    
    var persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func getAll(where predicate: NSPredicate?) throws -> [RepositoryObject] {
        let entityName = String(describing: RepositoryObject.StoreType.self)
        let request = NSFetchRequest<RepositoryObject.StoreType>(entityName: entityName)
        request.predicate = predicate
        
        let objects = try persistentContainer.viewContext.fetch(request)
        return objects.compactMap { $0.model }
    }

    func insert(item: RepositoryObject) throws {
        persistentContainer.viewContext.insert(item.toStorable(with: persistentContainer.viewContext))
        saveContext()
    }
    
    func update(item: RepositoryObject) throws {
        try? delete(item: item)
        try? insert(item: item)
    }
    
    func delete(item: RepositoryObject) throws {
        persistentContainer.viewContext.delete(item as! NSManagedObject)
        saveContext()
    }
    // MARK: - Core Data Saving support
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

class PersistentContainerFactory {
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application.
         */
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
