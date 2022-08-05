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
        if GlobalContext.shared.currentImage == nil{
        ZStack {
            FrameView(image: model.frame)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Button("Flip") {
                        model.positionswap()
                    }
                    Button("Capture") {
                        GlobalContext.shared.getcapturedimage(image: model.frame!)
                    }
                    
                    Button("debug") {
                        
                        }
                    }
                }
            }
        }else{
            ZStack{
                Image(uiImage: UIImage(cgImage: GlobalContext.shared.currentImage!)).resizable().frame(width: screenWidth, height: screenHeight, alignment: .center)
                    
                Button("save"){
                    GlobalContext.shared.savecapturedimage()
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
