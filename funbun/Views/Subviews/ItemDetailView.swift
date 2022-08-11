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
    @State var fetchingimg = false
    @State var itemtitle = "Debug title"
    @State var itemdesc = "Debug Desc"
    var testimg = Image(systemName: "circle")
    var xpadding = CGFloat(20)
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    globalcontext.currentScreen = 1
                },     label: {Image(systemName: "chevron.backward")})
                        .padding(.leading, xpadding)
                Spacer()
                Text(GlobalContext.shared.loadedItem.itemtitle)
                    .font(.largeTitle)
                .fontWeight(.black)
                .padding(.trailing, xpadding)
                Spacer()
            }
            Spacer()
            VStack {
                Text(GlobalContext.shared.loadedItem.itemdesc).padding(.top, 50)
                Spacer()
                if fetchingimg {
                    ProgressView().progressViewStyle(.circular).task {
                        let example = GlobalContext.shared.loadedItem.cellid
                        let img = await dataHandler.getImageFromDB(id: example)
                        viewcontext.loadedItem.itemimage = Image(uiImage: UIImage(data: img)!)
                        fetchingimg.toggle()
                    }
                } else {
                    viewcontext.loadedItem.itemimage
                        .resizable()
                        .frame(width: screenWidth - 50, height: 400, alignment: .center)
                }
                Spacer()
            }
            Spacer()
        }.onAppear(perform: {
            itemtitle = viewcontext.loadedItem.itemtitle
            itemdesc = viewcontext.loadedItem.itemdesc
            print(viewcontext.loadedItem.itemtitle)
            fetchingimg.toggle()
        })
    }
}
