//
//  UserContext.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import Foundation
import UIKit
import SwiftUI
import AVFoundation
import Photos

class GlobalContext: ObservableObject {
    let longvars = Longvars()
    static var rootbackground = Color(uiColor: UIColor(named: "BackgroundColor")!)
    static var cellBackground = Color(uiColor: UIColor(named: "CellColor")!)
    static var currentFormInput = FormInput(type: .inventoryItem)
    static var symbolbuttons = Longvars.selectionset
    static let shared = GlobalContext()
    @Published var currentScreen = 0
    @Published var currentList = [Items]()
    @Published var showsheet = false
    @Published var isInDismiss = false    
    @Published var loadedItem = WardrobeItemCell(itemtitle: "Debug", cellid: UUID(),itemdesc: "debug desc")
    @Published var currentImage: CGImage?
    // Updates the ViewModel With the current list in the database
    // Use this method in UI element actions that alter the DB in a way that needs to be reflected to the user context
    func updateList() async {
        currentList = await dataHandler.getDBItems()
    }
    func removeFromList(cellid: UUID) async {
        await dataHandler.deleteWithCellID(cellid: cellid)
    }
    func getcapturedimage(image:CGImage){
        self.currentImage = image
    }
    func savecapturedimage() {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {return}
            
        }
        UIImageWriteToSavedPhotosAlbum(UIImage(cgImage: GlobalContext.shared.currentImage!), nil, nil, nil)
        self.currentImage = nil
    }
}
