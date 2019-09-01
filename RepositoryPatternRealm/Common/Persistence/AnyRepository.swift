//
//  RealmRepository.swift
//  RepositoryPatternRealm
//
//  Created by Kristijan Kralj on 22/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation
import RealmSwift

class AnyRepository<RepositoryObject: Entity>: Repository {
    typealias RealmObject = RepositoryObject.StoreType
    
    private let realm: Realm

    init() {
        realm = try! Realm()
    }

    func getAll(where predicate: NSPredicate?) -> [RepositoryObject] {
        var objects = realm.objects(RealmObject.self as! Object.Type)

        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        return objects.compactMap{ ($0 as! RealmObject).entity as? RepositoryObject }
    }

    func insert(item: RepositoryObject) throws {
        try realm.write {
            realm.add(item.toStorable() as! Object)
        }
    }

    func update(item: RepositoryObject) throws {
        try? delete(item: item)
        try? insert(item: item)
    }

    func delete(item: RepositoryObject) throws {
        try realm.write {
            let predicate = NSPredicate(format: "uuid == %@", item.toStorable().uuid)
            if let productToDelete = realm.objects(RealmObject.self as! Object.Type)
                .filter(predicate).first {
                realm.delete(productToDelete)
            }
        }
    }
}

