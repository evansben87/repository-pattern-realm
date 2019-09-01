//
//  CDArticle+CoreDataProperties.swift
//  
//
//  Created by Kristijan Kralj on 01/09/2019.
//
//

import Foundation
import CoreData


extension CDArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDArticle> {
        return NSFetchRequest<CDArticle>(entityName: "CDArticle")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Double

}
