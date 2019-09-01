//
//  RealmRepositoryTests.swift
//  RepositoryPatternRealmTests
//
//  Created by Kristijan Kralj on 23/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import XCTest
import RealmSwift
@testable import RepositoryPatternRealm

class RealmRepositoryTests: XCTestCase {

    override func setUp() {
        // Use an in-memory Realm identified by the name of the current test.
        // This ensures that each test can't accidentally access or modify the data
        // from other tests or the application itself, and because they're in-memory,
        // there's nothing that needs to be cleaned up.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    func test_insert_stores_item_locally() {
        let article = Article(price: 149, name: "Apple Airpods")
        let repository = createRepository()
        
        try! repository.insert(item: article)
        let savedItems: [Article] = repository.getAll()
        
        XCTAssertEqual(1, savedItems.count)
    }

    func test_update_updates_item() {
        var article = Article(price: 149, name: "Apple Airpods")
        let repository = createRepository()
        try! repository.insert(item: article)

        //Hot sale
        article.price = 129
        
        try! repository.update(item: article)

        let savedItems: [Article] = repository.getAll()

        XCTAssertEqual(129, savedItems.first!.price)
    }
    
    func test_delete_removes_item() {
        let article = Article(price: 149, name: "Apple Airpods")
        let repository = createRepository()
        try! repository.insert(item: article)
        
        try! repository.delete(item: article)
        
        let savedItems: [Article] = repository.getAll()
        
        XCTAssertEqual(0, savedItems.count)
    }
    
    func test_getAll_filters_items() {
        let article = Article(price: 149, name: "Apple Airpods")
        
        let article2 = Article(price: 178, name: "Apple Airpods 2")
        let repository = createRepository()
        try! repository.insert(item: article)
        try! repository.insert(item: article2)

        let savedItems: [Article] = repository.getAll(where: NSPredicate(format: "name = %@", article2.name))
        
        XCTAssertEqual(1, savedItems.count)
    }
    
    private func createRepository() -> AnyRepository<Article> {
        return AnyRepository()
    }
}
