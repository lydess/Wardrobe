//
//  CameraView.swift
//  funbun
//
//  Created by william Vise on 5/8/2022.
//

import SwiftUI

struct CameraView: View {
    @StateObject private var model = ContentViewModel()
    var image: CGImage?
    let label = Text("Camera feed")
    var body: some View {
        ZStack {
            FrameView(image: model.frame)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Button("Flip"){
                    model.positionswap()
                }
            }
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
