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
    let pub = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
    @State var sheetdisplay = false
    @StateObject var viewContext = globalcontext
    @State var deleteItemIndicator = false
    @State var isCallingAPI = false
    @State var texttest = ""
    @State var testimg:Image
    var body: some View {
        VStack {
            Text("Debug view").font(.largeTitle).bold()
            Spacer()
            VStack {
                TextField("enter text", text: $texttest)
                    .onReceive(pub, perform: {_ in
                        GlobalContext.shared.keyboardisshown = true
                    })
                Button("responder test") {
                    isCallingAPI.toggle()
                }
                if isCallingAPI {
                    ProgressView().progressViewStyle(.circular).task {
                        let items = await dataHandler.getDBItems()
                        let example = items[0].id
                        var img = await dataHandler.getImageFromDB(id: example!)
                        self.testimg = Image(uiImage: UIImage(data: img)!)
                        
                    }
                } else {
                    testimg
                }
            Spacer()
        }
    }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView(testimg: Image(systemName: "circle"))
    }
}
