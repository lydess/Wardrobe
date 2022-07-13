//
//  Coredata.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import Foundation
import CoreData

class Database:ObservableObject {
    
     var context: NSPersistentContainer = {
            /*
             The persistent container for the application. This implementation
             creates and returns a container, having loaded the store for the
             application to it. This property is optional since there are legitimate
             error conditions that could cause the creation of the store to fail.
             */
            let container = NSPersistentContainer(name: "WDB")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
    
    func Save () {
            let context = context.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    func addnewitem() {
        let item = Items(context: DataHandler.context.viewContext)
        item.id = UUID()
        item.name = "test example"
        
        Save()
    }
    
    func removetopitem() async {
        let fetchrequest: NSFetchRequest<Items> = Items.fetchRequest()
        fetchrequest.returnsObjectsAsFaults = false
   
        do{
            try await context.viewContext.perform {
            let result = try fetchrequest.execute()
                if result.count == 0 {} else {self.context.viewContext.delete(result[0])}
                
                
            
            
        }
        }catch {
            print("failure")
        }
    }
    
    func GetDBItems() async -> [Items]{
        var final = [Items]()
        let fetchrequest: NSFetchRequest<Items> = Items.fetchRequest()
        fetchrequest.returnsObjectsAsFaults = false
   
        do{
            try await context.viewContext.perform {
            let result = try fetchrequest.execute()
           
            final = result
            
        }
        }catch {
            print("failure")
        }
        return final
    }
    
    

   
}
