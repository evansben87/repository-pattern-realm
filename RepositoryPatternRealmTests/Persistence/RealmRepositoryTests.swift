//
//  RealmRepositoryTests.swift
//  RepositoryPatternRealmTests
//
//  Created by Kristijan Kralj on 23/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import XCTest
import RealmSwift

class RealmRepositoryTests: XCTestCase {

    override func setUp() {
        // Use an in-memory Realm identified by the name of the current test.
        // This ensures that each test can't accidentally access or modify the data
        // from other tests or the application itself, and because they're in-memory,
        // there's nothing that needs to be cleaned up.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }

    func test_insert_stores_item_locally() {

    }
    
    func test_getAll_retrieves_all_items() {
        
    }
    
    func test_update_updates_item() {
        
    }
    
    func test_delete_removes_item() {
        
    }
}
