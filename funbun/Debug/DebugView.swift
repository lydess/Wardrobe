//
//  DebugView.swift
//  funbun
//
//  Created by william Vise on 14/7/2022.
//

import SwiftUI
let API = Networking()

struct DebugView: View {
    var debugcase = Debugtests()
    @State var sheetdisplay = false
    @StateObject var viewContext = globalcontext
    @State var deleteItemIndicator = false
    @State var isCallingAPI = false
    var body: some View {
        VStack {
            Text("Debug view").font(.largeTitle).bold()
            Spacer()
            VStack {
                Button("Delete DB item") {
                    deleteItemIndicator.toggle()
                }
                if deleteItemIndicator {ProgressView().progressViewStyle(.circular).task {
                    await dataHandler.removetopitem()
                    await viewContext.updateList()
                    deleteItemIndicator.toggle()
                }}
            }.frame(width: screenWidth, height: 100, alignment: .center).offset(x: 0, y: -300)
            Button("get user defaults") {print(userdefaults.string(forKey: "name_preference"))}
            SelectionView(rowContent: GlobalContext.symbolbuttons).background(.red)
            Button("bitmap info"){debugcase.photohash()}
            Spacer()
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
