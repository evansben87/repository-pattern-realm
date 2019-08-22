//
//  Entity.swift
//  RepositoryPatternRealm
//
//  Created by Kristijan Kralj on 22/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation

// implemented by your immutable structs
protocol Entity {
}

// Implemented by RealmSwift.Object subclasses
protocol RealmEntity {
    associatedtype EntityType
    
    init(_ entity: EntityType)
    var entity: EntityType { get }
}
