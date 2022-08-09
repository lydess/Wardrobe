//
//  Coredata.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import Foundation
import CoreData
import SwiftUI

class DataBase: ObservableObject {
     var context: NSPersistentContainer = {
            let container = NSPersistentContainer(name: "WDB")
            container.loadPersistentStores(completionHandler: { (_, error) in
                if let error = error as NSError? {

                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
    func save () {
            let context = context.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    func addCell() {
        let item = Items(context: dataHandler.context.viewContext)
        item.id = UUID()
        item.name = "test example"
        save()
    }
    func addForm(form: FormInput) {
        let item = Items(context: dataHandler.context.viewContext)
        item.id = UUID()
        item.name = form.name
        item.date = form.date
        item.itemdesc = form.desc
        item.photo = form.photo
        GlobalContext.shared.currentImage = nil
        GlobalContext.shared.currentFormInput.reset()
        print("Saved new item to persistant store, reseting current form....")
        save()
    }
    func removetopitem() async {
        let fetchrequest: NSFetchRequest<Items> = Items.fetchRequest()
        fetchrequest.returnsObjectsAsFaults = false
        do {
            try await context.viewContext.perform {
            let result = try fetchrequest.execute()
                if result.count == 0 {} else {self.context.viewContext.delete(result[0])}
        }
        } catch {
            print("failure")
        }
        save()
    }
    func deleteWithCellID(cellid: UUID) async {
        let fetchrequest: NSFetchRequest<Items> = Items.fetchRequest()
        let pred = NSPredicate(format: "id == %@", cellid as CVarArg)
        fetchrequest.predicate = pred
        do {
            try await context.viewContext.perform {
                let result = try fetchrequest.execute()
                if result.count == 0 {} else {self.context.viewContext.delete(result[0])}
            }
        } catch {print(error)}
        save()
    }
    func deleteWithTitle(title: String) async {
        var fetchrequest: NSFetchRequest<Items> = Items.fetchRequest()
        fetchrequest.returnsObjectsAsFaults = false

        let pred = NSPredicate(format: "name == %@", title as CVarArg)
        fetchrequest.predicate = pred
        do {
            let results = try self.context.viewContext.fetch(fetchrequest) as [NSManagedObject]
            self.context.viewContext.delete(results[0])
            
  
        } catch {print(error)}
        save()
    }
    
    func getDBItems() async -> [Items] {
        var final = [Items]()
        let fetchrequest: NSFetchRequest<Items> = Items.fetchRequest()
        fetchrequest.returnsObjectsAsFaults = false
        do {
            try await context.viewContext.perform {
            let result = try fetchrequest.execute()
            final = result
        }
        } catch {
            print("failure")
        }
        return final
    }
    func getImageFromDB(id: UUID) async -> Data {
        var finaldata = Data()
        let fetchrequest: NSFetchRequest<Items> = Items.fetchRequest()
        fetchrequest.returnsObjectsAsFaults = false

        let pred = NSPredicate(format: "id == %@", id as CVarArg)
        fetchrequest.predicate = pred
        do {
            try await context.viewContext.perform {
            let result = try fetchrequest.execute()
                finaldata = result[0].photo!
        }
        } catch {
            print("failure")
        }
        return finaldata
    }
}
