//
//  RealmRepository.swift
//  RepositoryPatternRealm
//
//  Created by Kristijan Kralj on 22/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation
import RealmSwift

// A RealmRepository that implements the Repository protocol on top of Realm
class RealmRepository<T>: Repository where T: RealmEntity, T: Object, T.EntityType: Entity {
    typealias RealmEntityType = T
    
    private let realm: Realm
    
    init() {
        realm = try! Realm()
    }
    
    func getAll() -> [T.EntityType] {
        return realm.objects(T.self).compactMap { $0.entity }
    }
    
    func save(item: T.EntityType) {
        try? realm.write {
            realm.add(RealmEntityType(item))
        }
    }

    func delete(item: T.EntityType) {
        try? realm.write {
            realm.delete(RealmEntityType(item))
        }
    }
}
