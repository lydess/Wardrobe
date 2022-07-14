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
    
    var body: some View {
        VStack {
            Text("Debug view")
            Button("display sheet"){ViewContext.showsheet.toggle()}
        }
    }
}

struct DebugView_Previews: PreviewProvider {
    static var previews: some View {
        DebugView()
    }
}
