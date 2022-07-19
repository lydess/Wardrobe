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
}

struct Symbolcollection {
    var symbols = ["tshirt", "refrigerator", "screwdriver", "cart", "dumbbell", "graduationcap.circle"]
}
