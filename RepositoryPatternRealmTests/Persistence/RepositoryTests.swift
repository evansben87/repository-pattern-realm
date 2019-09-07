//
//  RealmRepositoryTests.swift
//  RepositoryPatternRealmTests
//
//  Created by Kristijan Kralj on 23/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import XCTest
import CoreData
@testable import RepositoryPatternRealm

class RepositoryTests: XCTestCase {

    func test_insert_stores_item_locally() {
        let article = Article(price: 149, name: "Apple Airpods")
        let repository = createRepository()
        
        try! repository.insert(item: article)
        let savedItems: [Article] = try! repository.getAll()
        
        XCTAssertEqual(1, savedItems.count)
    }

    func test_update_updates_item() {
        var article = Article(price: 149, name: "Apple Airpods")
        let repository = createRepository()
        try! repository.insert(item: article)

        //Hot sale
        article.price = 129
        
        try! repository.update(item: article)

        let savedItems: [Article] = try! repository.getAll()

        XCTAssertEqual(129, savedItems.first!.price)
    }
    
    func test_delete_removes_item() {
        let article = Article(price: 149, name: "Apple Airpods")
        let repository = createRepository()
        try! repository.insert(item: article)
        
        try! repository.delete(item: article)
        
        let savedItems: [Article] = try! repository.getAll()
        
        XCTAssertEqual(0, savedItems.count)
    }
    
    func test_getAll_filters_items() {
        let article = Article(price: 149, name: "Apple Airpods")
        
        let article2 = Article(price: 178, name: "Apple Airpods 2")
        let repository = createRepository()
        try! repository.insert(item: article)
        try! repository.insert(item: article2)

        let savedItems: [Article] = try! repository.getAll(where: NSPredicate(format: "name == %@", article2.name))
        
        XCTAssertEqual(1, savedItems.count)
    }
    
    private func createRepository() -> CoreDataRepository<Article> {
        return CoreDataRepository(persistentContainer: CoreDataHelper().persistentContainer)
    }
}
