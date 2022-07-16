//
//  CustomModels.swift
//  funbun
//
//  Created by william Vise on 14/7/2022.
//

import Foundation

enum FormType {
    case inventoryItem
    case newUser
    case settingsProfile

}

struct FormInput {
    var type:FormType
    var name = ""
    var id = UUID()
    var date = Date()
}

