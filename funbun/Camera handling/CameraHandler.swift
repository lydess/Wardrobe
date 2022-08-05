//
//  CameraHandler.swift
//  funbun
//
//  Created by william Vise on 5/8/2022.
//

import Foundation
import SwiftUI
import UIKit
import AVFoundation

class CameraHandler: ObservableObject{
    // 1
    @Published var error: AVError.Code?
    @Published var campos = AVCaptureDevice.Position.back
    // 2
    let session = AVCaptureSession()
    
    // 3
    private let sessionQueue = DispatchQueue(label: "com.lydess.SessionQ")
    // 4
    private let videoOutput = AVCaptureVideoDataOutput()
    // 5
    private var status = Status.unconfigured

    enum Status {
        case unconfigured
        case configured
        case unauthorized
        case failed
      }
      // 3
      static let shared = CameraHandler()
      // 4
      private init() {
        configure()
      }
      // 5
      private func configure() {
          checkPermissions()
          sessionQueue.async {
            self.configureCaptureSession()
            self.session.startRunning()
          }

          
      }
    func cameraswap() {
        postoggle()
        checkPermissions()
        sessionQueue.async {
            self.removeinputs()
            self.status = .unconfigured
            self.configureCaptureSession()
            self.session.startRunning()
            self.status = .configured
            
            
        }
    }
    
    func postoggle() {
        if self.campos == AVCaptureDevice.Position.front {
            self.campos = AVCaptureDevice.Position.back
            return
        }else{
            self.campos = AVCaptureDevice.Position.front
        }
    }
    
    private func configureCaptureSession() {
            guard status == .unconfigured else {
                return
            }
            session.beginConfiguration()
            let device = AVCaptureDevice.default(
                .builtInWideAngleCamera,
                for: .video,
                position: campos)
            guard let camera = device else {
                set(error: .deviceNotConnected)
                status = .failed
                return
            }
            
            defer {
                
                session.commitConfiguration()
            }
            do {
                
                // 1
                let cameraInput = try AVCaptureDeviceInput(device: camera)
                // 2
                if session.canAddInput(cameraInput) {
                    session.addInput(cameraInput)
                } else {
                    // 3
                    set(error: .sessionConfigurationChanged)
                    status = .failed
                    return
                }
            } catch {
                // 4
                set(error: .sessionConfigurationChanged)
                status = .failed
                return
            }
            // 1
            if session.canAddOutput(videoOutput) {
                session.addOutput(videoOutput)
                // 2
                videoOutput.videoSettings =
                [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
                // 3
                let videoConnection = videoOutput.connection(with: .video)
                videoConnection?.videoOrientation = .portrait
                videoConnection?.videoPreviewLayer?.isGeometryFlipped = true
            } else {
                // 4
                set(error: .sessionNotRunning)
                status = .failed
                return
            }
            
            
            status = .configured

    }
    
    func removeinputs() {
        session.beginConfiguration()
        do {
            session.removeInput(session.inputs[0])
            session.removeOutput(session.outputs[0])
            
        } catch {
            // 4
            set(error: .sessionConfigurationChanged)
            status = .failed
            return
        }
        session.commitConfiguration()
            
        
    }

    private func set(error: AVError.Code) {
        DispatchQueue.main.async {
        self.error = error
        }}
    private func checkPermissions() {
      // 1
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .notDetermined:
                // 2
                sessionQueue.suspend()
                AVCaptureDevice.requestAccess(for: .video) { authorized in
                    // 3
                    if !authorized {
                        self.status = .unauthorized
                        self.set(error: .applicationIsNotAuthorizedToUseDevice)
                    }
                    self.sessionQueue.resume()
                }
                // 4
            case .restricted:
                status = .unauthorized
                set(error: .applicationIsNotAuthorizedToUseDevice)
            case .denied:
                status = .unauthorized
                set(error: .applicationIsNotAuthorizedToUseDevice)
                // 5
            case .authorized:
                break
                // 6
            @unknown default:
                status = .unauthorized
                set(error: .applicationIsNotAuthorizedToUseDevice)
            }
    }
    func set(
      _ delegate: AVCaptureVideoDataOutputSampleBufferDelegate,
      queue: DispatchQueue
    ) {
      sessionQueue.async {
        self.videoOutput.setSampleBufferDelegate(delegate, queue: queue)
      }
    }



}
