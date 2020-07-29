//
//  ArticleManager.swift
//  Pods-vfil2019_Example
//
//  Created by  Vladyslav Fil on 10/9/19.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
class ArticleManager: NSObject {
    
    
    private lazy var persistentContainer: NSPersistentContainer? = {
        let modelURL = Bundle(for: Article.self).url(forResource: "Article", withExtension: "momd")
        
        var container: NSPersistentContainer
        
        guard let model = modelURL.flatMap(NSManagedObjectModel.init) else {
            print("Fail to load the trigger model!")
            return nil
        }
        
        container = NSPersistentContainer(name: "Article", managedObjectModel: model)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    private var managedObjectContext: NSManagedObjectContext?
    
    public override init() {
        super.init()
        managedObjectContext = persistentContainer?.viewContext
        var article: Article!
        managedObjectContext?.performAndWait {
            let ent = NSEntityDescription.entity(forEntityName: "Article", in: managedObjectContext!)
            article = Article(entity: ent!, insertInto: managedObjectContext!)
            do {
                try managedObjectContext?.save()
            }
            catch(let error)
            {
                print(error)
            }
        }
    }
    
//    func newArticle() -> Article {
//
//    }
//
//    func getAllArticles() -> [Article] {
//
//    }
//
//    func getArticles(withLang lang: String) -> [Article] {
//
//    }
//
//    func getArticles(containString str: String) -> [Article] {
//
//    }
//
//    func removeArticle(article: Article) {
//
//    }
//
//    func save() {
//
//    }
}
