//
//  Coredata.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import Foundation
import CoreData

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
    func removeCell(cellid: UUID) async {
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
}
