//
//  CoreDataManager.swift
//  PixaBay Search
//
//  Created by gaurav on 17/10/20.
//  Copyright © 2020 mackbook. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
  

  static let sharedManager = CoreDataManager()

  private init() {} // Prevent clients from creating another instance.
  

  lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "PIxaBay")
    
    
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  

  func saveContext () {
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
    
    func insertTag(name: String){
      let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
   
      let entity = NSEntityDescription.entity(forEntityName: "Search",
                                              in: managedContext)!
       let dataObject =  self.fetchAllTags()
        
        if !dataObject.contains(name){
            validateQueryItems()
            let tags = NSManagedObject(entity: entity,
                                              insertInto: managedContext)
                 
                 tags.setValue(name, forKeyPath: "name")
               
                 do {
                   try managedContext.save()
                   print("save successfully")
                   
                 } catch let error as NSError {
                   print("Could not save. \(error), \(error.userInfo)")
                  
                 }
        }
     
    }
    
    func fetchAllTags() -> [String]{
      let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
    
      let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Search")
        
      do {
        let tags = try managedContext.fetch(fetchRequest)
    
        var tagName = [String]()
        for data in tags{
            tagName.append(data.value(forKey: "name") as? String ?? "")
       }
        return tagName
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
        
      }
    return []
    }
    
    func validateQueryItems(){
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Search")
        do {
               let tags = try managedContext.fetch(fetchRequest)
            if let manageObject = tags.first, tags.count == 10{
                managedContext.delete(manageObject)
            }
            do {
                try managedContext.save()
                print("save successfully")
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                
            }
             } catch let error as NSError {
               print("Could not fetch. \(error), \(error.userInfo)")
               
             }
             
    }
    
}
