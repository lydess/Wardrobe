//
//  KeyboardHandler.swift
//  funbun
//
//  Created by william Vise on 9/8/2022.
//

import Foundation
import SwiftUI
import UIKit

class KeyBoardHandler: ObservableObject {
    static let shared = KeyBoardHandler()

    init() {
            let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(willshow),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(willhide),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
        
        }
    @objc func willshow() {
            print("keyboard will show")
        }
    
    @objc func willhide() {
            print("keyboard will hide")
        }
}
