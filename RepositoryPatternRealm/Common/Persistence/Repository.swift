//
//  Repository.swift
//  RepositoryPatternRealm
//
//  Created by Kristijan Kralj on 22/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation

protocol Repository {
    func getAll<T: Storable>(where predicate: NSPredicate?) -> [T]
    func insert(item: Storable) throws
    func update(block: @escaping () -> ()) throws
    func delete(item: Storable) throws
}

extension Repository {
    func getAll<T: Storable>() -> [T] {
        return getAll(where: nil)
    }
}

public protocol Storable { }
