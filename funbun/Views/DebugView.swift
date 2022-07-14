//
//  DebugView.swift
//  funbun
//
//  Created by william Vise on 14/7/2022.
//

import SwiftUI

struct DebugView: View {
    @State var Sheetdisplay = false
    
    var body: some View {
        VStack {
            Text("Debug view")
            Button("display sheet"){Sheetdisplay.toggle()}.sheet(isPresented: $Sheetdisplay, content: {AddItemForm()})
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
