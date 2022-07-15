//
//  CustomModels.swift
//  funbun
//
//  Created by william Vise on 14/7/2022.
//

import Foundation

enum FormType {
    case InventoryItem
    case NewUser
    case SettingsProfile

}

struct FormInput {
    var type:FormType
    var Name = ""
    var id = UUID()
    var date = Date()
}

