//
//  CameraFrameManager.swift
//  funbun
//
//  Created by william Vise on 5/8/2022.
//

import Foundation
import AVFoundation
// 1
class FrameManager: NSObject, ObservableObject {
  // 2
  static let shared = FrameManager()
  // 3
  @Published var current: CVPixelBuffer?
  // 4
  let videoOutputQueue = DispatchQueue(
    label: "com.lydess.VideoOutputQ",
    qos: .userInitiated,
    attributes: [],
    autoreleaseFrequency: .workItem)
  // 5
  private override init() {
    super.init()
    CameraHandler.shared.set(self, queue: videoOutputQueue)
  }
}

extension FrameManager: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(
    _ output: AVCaptureOutput,
    didOutput sampleBuffer: CMSampleBuffer,
    from connection: AVCaptureConnection
  ) {
    if let buffer = sampleBuffer.imageBuffer {
      DispatchQueue.main.async {
        self.current = buffer
      }
    }
  }
}
