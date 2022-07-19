//
//  DebugView.swift
//  funbun
//
//  Created by william Vise on 14/7/2022.
//

import SwiftUI

struct DebugView: View {
    @State var Sheetdisplay = false
    @StateObject var ViewContext = Globalcontext
    @State var DeleteItemIndicator = false
    var body: some View {
        VStack {
            Text("Debug view").font(.largeTitle).bold()
            Spacer()
            VStack {
                Button("Delete DB item"){
                    DeleteItemIndicator.toggle()
                    
                }
                if DeleteItemIndicator {ProgressView().progressViewStyle(.circular).task {
                    await DataHandler.removetopitem()
                    await ViewContext.UpdateList()
                    DeleteItemIndicator.toggle()
                }}
            }.frame(width: ScreenWidth, height: 100, alignment: .center).offset(x: 0, y: -300)
            Button("get user defaults"){print(userdefaults.string(forKey: "name_preference  "))}
            
            Spacer()
            
            
            
            
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
