//
//  StorableArticle.swift
//  RepositoryPatternRealm
//
//  Created by Kristijan Kralj on 31/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation
import RealmSwift

extension Article: Entity {
    private var storableArticle: StorableArticle {
        let realmArticle = StorableArticle()
        realmArticle.name = name
        realmArticle.price = price
        realmArticle.uuid = name
        return realmArticle
    }
    
    func toStorable() -> StorableArticle {
        return storableArticle
    }
}

class StorableArticle: Object, Storable {
    
    @objc dynamic var price: Double = 0.0
    @objc dynamic var name: String = ""
    @objc dynamic var uuid: String = ""
    
    var entity: Article
    {
        get {
            return Article(price: price, name: name)
        }
    }
}
