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
                }
            Spacer()
            
        }
    }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
