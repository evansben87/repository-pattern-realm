//
//  Article.swift
//  RepositoryPatternRealm
//
//  Created by Kristijan Kralj on 23/08/2019.
//  Copyright © 2019 Kristijan Kralj. All rights reserved.
//

import Foundation
import RealmSwift

class Article: Object {
    @objc dynamic var price: Double = 0.0
    @objc dynamic var name: String = ""
}
