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
    
    func setlist() async {
        examplelist = await DataHandler.GetDBItems()
        print("List is set, here it is")
        print(examplelist)
    }
    
    
    
}

struct Debugitem:Identifiable {
    var id = UUID()
    var title:String
     
}
