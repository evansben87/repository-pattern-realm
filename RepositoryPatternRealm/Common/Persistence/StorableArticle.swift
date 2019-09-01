//
//  StorableArticle.swift
//  RepositoryPatternRealm
//
//  Created by Kristijan Kralj on 31/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation
import CoreData

extension Article: Entity {
    public func toStorable(with context: NSManagedObjectContext) -> CDArticle {
        
        let coreDataArticle = CDArticle(context: context)
        coreDataArticle.name = name
        coreDataArticle.price = price
        return coreDataArticle
    }
}

extension CDArticle: Storable {
    public var uuid: String {
        return name!
    }

    public var model: Article
    {
        get {
            return Article(price: price, name: name ?? "")
        }
    }
}
