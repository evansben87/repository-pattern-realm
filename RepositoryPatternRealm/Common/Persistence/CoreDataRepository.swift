//
//  CoreDataRepository.swift
//  RepositoryPatternRealm
//
//  Created by Kristijan Kralj on 31/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation
import CoreData

class CoreDataRepository {
    // MARK: - Core Data stack
    
    var persistentContainer: NSPersistentContainer
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func getAll<T>(where predicate: NSPredicate?) -> [T] where T : Storable {
        return getAllObjects(where: predicate) as! [T]
    }
    
//    func insert(item: Storable) throws {
//        guard item is NSManagedObject else { return }
//        
//        backgroundContext.insert(item as! NSManagedObject)
//        saveContext()
//    }
//    
//    func update(block: @escaping () -> ()) throws {
//        block()
//        saveContext()
//    }
//    
//    func delete(item: Storable) throws {
//        guard item is NSManagedObject else { return }
//        backgroundContext.delete(item as! NSManagedObject)
//        saveContext()
//    }
    
    // MARK: - Core Data Saving support
    
    func getAllObjects<T: NSManagedObject>(where predicate: NSPredicate?) -> [T] {
        let entityName = String(describing: T.self)
        let request = NSFetchRequest<T>(entityName: entityName)
        request.predicate = predicate
        
        let objects = try? persistentContainer.viewContext.fetch(request)
        
        return objects ?? [T]()
        //try persistentContainer.viewContext
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
        let container = NSPersistentContainer(name: "RepositoryPattern")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
