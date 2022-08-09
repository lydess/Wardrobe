//
//  CameraView.swift
//  funbun
//
//  Created by william Vise on 5/8/2022.
//

import SwiftUI

struct CameraView: View {
    @StateObject private var model = ContentViewModel()
    @StateObject var viewContext = globalcontext
    private var debugcase = Debugtests()
    private var image: CGImage?
    private let label = Text("Camera feed")
    var body: some View {
        if GlobalContext.shared.currentImage == nil {
        ZStack {
            FrameView(image: model.frame)
                .edgesIgnoringSafeArea(.all)
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))      // cameras are weird, this makes the output look more natural
            VStack {
                HStack{
                    Button("<"){
                        viewContext.currentScreen = 1
                        viewContext.cameraisshown = false
                        viewContext.showsheet = true
                        
                    }.padding(.top,40)
                        .padding(.leading, 30)
                    Spacer()
                }
                Spacer()
                HStack {
                    Button("Flip") {
                        model.positionswap()
                    }.padding()
                    Button("Capture") {
                        GlobalContext.shared.getcapturedimage(image: model.frame!)
                    }.padding()
                    Button("Debug") {
                    }.padding()
                    }
                }
            }
        } else {
            ZStack {
                Image(uiImage: UIImage(cgImage: GlobalContext.shared.currentImage!))
                    .resizable()
                    .frame(width: screenWidth, height: screenHeight, alignment: .center)
                    
                VStack {
                    HStack{
                        Button("X"){
                            GlobalContext.shared.currentImage = nil
                            
                        }.padding([.top, .leading],40)
                        Spacer()
                    }
                    Spacer()
                    Button("set image") {
                        viewContext.currentScreen = 1
                        viewContext.cameraisshown = false
                        viewContext.showsheet = true
                        
                    }.padding(.bottom, 75)
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
