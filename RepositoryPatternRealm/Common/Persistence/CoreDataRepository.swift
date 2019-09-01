//
//  CoreDataRepository.swift
//  RepositoryPatternRealm
//
//  Created by Kristijan Kralj on 31/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation
import CoreData

class CoreDataRepository<RepositoryObject: Entity>: Repository {
    // MARK: - Core Data stack
    
    var persistentContainer: NSPersistentContainer
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func getAll(where predicate: NSPredicate?) -> [RepositoryObject] {
        return getAllObjects(where: predicate) as! [RepositoryObject]
    }

    func insert(item: RepositoryObject) throws {
        guard item.toStorable(with: backgroundContext) is NSManagedObject else { return }
        backgroundContext.insert(item as! NSManagedObject)
        saveContext()
    }
    
    func update(item: RepositoryObject) throws {
        try? delete(item: item)
        try? insert(item: item)
    }
    
    func delete(item: RepositoryObject) throws {
        guard item.toStorable(with: backgroundContext) is NSManagedObject else { return }
        backgroundContext.delete(item as! NSManagedObject)
        saveContext()
    }
    // MARK: - Core Data Saving support
    
    func getAllObjects<T: NSManagedObject>(where predicate: NSPredicate?) -> [T] {
        let entityName = String(describing: T.self)
        let request = NSFetchRequest<T>(entityName: entityName)
        request.predicate = predicate
        
        let objects = try? persistentContainer.viewContext.fetch(request)
        
        return objects ?? [T]()
    }
    
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

struct PersistentContainerFactory {
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
