//
//  CustomModels.swift
//  funbun
//
//  Created by william Vise on 14/7/2022.
//

import Foundation
import SwiftUI
enum FormType {
    case inventoryItem
    case newUser
    case settingsProfile

}

struct FormInput {
    var type: FormType
    var name = ""
    var id = UUID()
    var date = Date()
    var desc = ""
    var photo = Data()
    
    mutating func reset() {
        self.type = .inventoryItem
        self.name = ""
        self.id = UUID()
        self.date = Date()
        self.desc = ""
        self.photo = Data()
    }
}

struct SelectionSymbol {
    var name: String
    var id = UUID()
}
