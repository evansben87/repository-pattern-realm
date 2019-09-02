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
        let objects = try! getManagedObjects(with: predicate)
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
        let predicate = NSPredicate(format: "uuid == %@", item.toStorable(with: persistentContainer.viewContext).uuid)
        let items = try! getManagedObjects(with: predicate)

        persistentContainer.viewContext.delete(items.first!)
        saveContext()
    }
    
    private func getManagedObjects(with predicate: NSPredicate?) throws -> [RepositoryObject.StoreType] {
        let entityName = String(describing: RepositoryObject.StoreType.self)
        let request = NSFetchRequest<RepositoryObject.StoreType>(entityName: entityName)
        request.predicate = predicate
        
        return try persistentContainer.viewContext.fetch(request)
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
