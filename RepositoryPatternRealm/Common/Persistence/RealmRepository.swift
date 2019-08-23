//
//  RealmRepository.swift
//  RepositoryPatternRealm
//
//  Created by Kristijan Kralj on 22/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation
import RealmSwift


extension Object: Storable {
}

class RealmRepository: Repository {
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func getAll<T: Storable>(where predicate: NSPredicate?) -> [T] {
        var objects = realm.objects(T.self as! Object.Type)
        
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        
        return objects.compactMap { $0 as? T }
    }
    
    func insert(item: Storable) throws {
        try realm.write {
            realm.add(item as! Object)
        }
    }
    
    func update(block: @escaping () -> Void) throws {
        try realm.write {
            block()
        }
    }
    
    func delete(item: Storable) throws {
        try realm.write {
            realm.delete(item as! Object)
        }
    }
}

