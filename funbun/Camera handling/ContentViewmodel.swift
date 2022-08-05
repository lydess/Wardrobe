//
//  ContentViewmodel.swift
//  funbun
//
//  Created by william Vise on 5/8/2022.
//

import Foundation
import UIKit
import SwiftUI
import CoreImage

class ContentViewModel: ObservableObject {
  
  @Published var frame: CGImage?
    @Published var error: Error?
  private let cameraManager = CameraHandler.shared
  private let frameManager = FrameManager.shared
    
    

  init() {
    setupSubscriptions()
  }

  func setupSubscriptions() {
      frameManager.$current
        .receive(on: RunLoop.main)
        .compactMap { buffer in
          return CGImage.create(from: buffer)
        }
        .assign(to: &$frame)
        

  }
    
    func positionswap() {
        cameraManager.cameraswap()
    }
}
