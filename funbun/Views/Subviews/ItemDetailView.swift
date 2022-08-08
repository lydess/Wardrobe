//
//  ItemDetailView.swift
//  funbun
//
//  Created by william Vise on 8/8/2022.
//

import Foundation
import SwiftUI
struct ItemDetailView: View {
    @StateObject var viewcontext = GlobalContext()
    var xpadding = CGFloat(20)
    var body: some View {
        
        VStack {
            HStack {
                Button(action: {
                    globalcontext.currentScreen = 1
                    print("should b goin back")
                }, label: {Image(systemName: "chevron.backward")})
                    .padding(.leading, xpadding)
                Spacer()
                Text(viewcontext.loadedItem.itemtitle)
                    .font(.largeTitle)
                .fontWeight(.black)
                .padding(.trailing, xpadding)
                Spacer()
            }
            Spacer()
            VStack {
                Text(viewcontext.loadedItem.itemdesc).padding(.top,50)
                Spacer()
                Text("Image")
                Spacer()
            }
            Spacer()
            
        }
        
    }
}



