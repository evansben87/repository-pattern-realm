//
//  Repository.swift
//  RepositoryPatternRealm
//
//  Created by Kristijan Kralj on 22/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation

// protocol to define the operations one can perform on a repository
protocol Repository {
    associatedtype EntityType
    
    func getAll() -> [EntityType]
    func save(item: EntityType)
    func delete(item: EntityType)
}
