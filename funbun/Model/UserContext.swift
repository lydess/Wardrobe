//
//  UserContext.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import Foundation
import UIKit
import SwiftUI

class GlobalContext: ObservableObject {
    static var rootbackground = Color(uiColor: UIColor(named: "BackgroundColor")!)
    static var cellBackground = Color(uiColor: UIColor(named: "CellColor")!)
    static var currentFormInput = FormInput(type: .inventoryItem)
    static var symbolbuttons = ["tshirt", "refrigerator", "screwdriver", "cart", "dumbbell", "graduationcap.circle"]
    @Published var currentScreen = 0
    @Published var currentList = [Items]()
    @Published var showsheet = false
    @Published var isInDismiss = false
    // Updates the ViewModel With the current list in the database
    // Use this method in UI element actions that alter the DB in a way that needs to be reflected to the user context
    func updateList() async {
        currentList = await dataHandler.getDBItems()
    }
    func removeFromList(cellid: UUID) async {
        await dataHandler.removeCell(cellid: cellid)
    }
}
