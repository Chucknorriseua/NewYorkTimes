//
//  Persistens.swift
//  NYTNews
//
//  Created by Евгений Полтавец on 30/01/2025.
//

import CoreData
import UIKit

struct PersistenceController {
    static let shared = PersistenceController()

   
    let container: NSPersistentContainer
    
 
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SaveNewsCoreData")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        let description = container.persistentStoreDescriptions.first!
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

   
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    func addItem(id: Int, title: String, url: String, creator: String, description: String, image: Data?, date: String, adxKeywords: String) -> SaveNewsCoreData {
        let newItem = SaveNewsCoreData(context: viewContext)

        newItem.image = image
        newItem.id = Int64(id)
        newItem.title = title
        newItem.creator = creator
        newItem.desc = description
        newItem.date = date
        newItem.url = url
        newItem.adxKeywords = adxKeywords
        
        saveContext()
        return newItem
    }


    func fetchAllItems() -> [SaveNewsCoreData]? {
        let request: NSFetchRequest<SaveNewsCoreData> = SaveNewsCoreData.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Failed to fetch items: \(error)")
            return nil
        }
    }


    func deleteItem(item: SaveNewsCoreData) {
        viewContext.delete(item)
        saveContext()
    }
    

    func deleteAllItems() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = SaveNewsCoreData.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(deleteRequest)
        } catch {
            print("Failed to delete all items: \(error)")
        }
    }
}
