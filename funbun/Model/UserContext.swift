//
//  UserContext.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import Foundation

class GlobalContext: ObservableObject {
    @Published var CurrentScreen = 0
    @Published var examplelist = [Items]()
    
    // Updates the ViewModel With the current list in the database
    // Use this method in UI element actions that alter the DB in a way that needs to be reflected to the user context
    func UpdateList() async {
        examplelist = await DataHandler.GetDBItems()
    }
    
    
    
}


