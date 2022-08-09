//
//  Debug class.swift
//  funbun
//
//  Created by william Vise on 19/7/2022.
//

import Foundation
import UIKit
import SwiftUI

class Debugtests: ObservableObject {
    var uib = UIKeyboardType(rawValue: 1)
    var binphoto = GlobalContext.shared.currentImage
    let notif = NotificationCenter.default
    
    
    func photohash() {
        var ex = UIImage(cgImage: GlobalContext.shared.currentImage!).pngData()
        print(binphoto?.bytesPerRow)
        var blob = ex! as Data
        GlobalContext.shared.currentFormInput.photo = blob
    }
    
    func testresponder() {
        
       
    }
    
}

struct Testjson: Codable {
    var val1 = 1
    var val2 = 2
}
