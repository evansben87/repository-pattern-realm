//
//  Repository.swift
//  RepositoryPatternRealm
//
//  Created by Kristijan Kralj on 22/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation

protocol Repository {
    func getAll<T: Storable>() -> [T]
    func insert(item: Storable) throws
    func update(block: @escaping () -> ()) throws
    func delete(item: Storable) throws
}

public protocol Storable { }
