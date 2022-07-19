//
//  SelectionView.swift
//  funbun
//
//  Created by william Vise on 19/7/2022.
//

import SwiftUI
// i could stand to make this polymorphic but for the time being ill keep it hardcoded
struct SelectionView: View {
    @State var rowContent: [String]
    @StateObject var viewcontext = globalcontext
    let rowSetup = [GridItem(.fixed(30))]
    var body: some View {
        ScrollView(.horizontal){
            LazyHGrid(rows: rowSetup) {
                ForEach(GlobalContext.symbolbuttons, id: \.self) { item in
                    Image(systemName: item)
                                
                                
                                   
                            }
                        }
        }
    }
}

