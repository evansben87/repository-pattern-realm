//
//  StorableArticle.swift
//  RepositoryPatternRealm
//
//  Created by Kristijan Kralj on 31/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation
import CoreData

extension Article: Entity {
    public func toStorable(with context: NSManagedObjectContext) -> CDArticle {
        
        let coreDataArticle = CDArticle.getOrCreateSingle(with: name, from: context)
        coreDataArticle.name = name
        coreDataArticle.uuid = name
        coreDataArticle.price = price
        return coreDataArticle
    }
}

extension CDArticle: Storable {
    public var model: Article
    {
        get {
            return Article(price: price, name: name ?? "")
        }
    }
}

extension Storable where Self: NSManagedObject {
    
    static func getOrCreateSingle(with uuid: String, from context: NSManagedObjectContext) -> Self {
        let result = single(with: uuid, from: context) ?? insertNew(in: context)
        result.setValue(uuid, forKey: "uuid")
        return result
    }
    
    static func single(with uuid: String, from context: NSManagedObjectContext) -> Self? {
        return fetch(with: uuid, from: context)?.first
    }
    
    static func insertNew(in context: NSManagedObjectContext) -> Self {
        return Self(context:context)
    }
    
    static func fetch(with uuid: String, from context: NSManagedObjectContext) -> [Self]? {
        let entityName = String(describing: Self.self)
        let fetchRequest = NSFetchRequest<Self>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", uuid)
        fetchRequest.fetchLimit = 1

        let result: [Self]? = try? context.fetch(fetchRequest)
        
        return result
    }
}
