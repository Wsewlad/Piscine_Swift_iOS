//
//  Article.swift
//  Pods-vfil2019_Example
//
//  Created by  Vladyslav Fil on 10/9/19.
//
//

import Foundation
import CoreData

public class Article: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var language: String?
    @NSManaged public var image: Data?
    @NSManaged public var creationDate: Date?
    @NSManaged public var modificationDate: Date?
    
    public override var description: String {
        return "\(title!)\n\(content!)\n\(language!)\n\(creationDate!)\n\(modificationDate!)"
    }
}
