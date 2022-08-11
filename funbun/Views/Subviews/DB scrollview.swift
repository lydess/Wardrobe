//
//  DB scrollview.swift
//  funbun
//
//  Created by william Vise on 13/7/2022.
//

import SwiftUI

struct DbScrollView: View {
    @StateObject var viewContext = globalcontext
    var body: some View {
        VStack {
            ScrollView {
            ForEach(viewContext.currentList, id: \.id) { item in
                var itemcell = WardrobeItemCell(itemtitle: item.name!,
                                                cellid: item.id!,
                                                itemdesc: item.description,
                                                itemimage: Image(systemName: "circle"))
                Button(action: {
                    GlobalContext.shared.loadedItem.cellid = item.id!
                    GlobalContext.shared.loadedItem.itemdesc = item.itemdesc ?? ""
                    GlobalContext.shared.loadedItem.itemtitle = item.name!
                    viewContext.currentScreen = 15
                   },
                       label: {
                    WardrobeItemCell(itemtitle: item.name!,
                                     cellid: item.id ?? UUID(),
                                     itemdesc: "471547158 desc",
                                     itemimage: Image(systemName: "circle"))})
                .buttonStyle(.plain)
            }
            }.menuIndicator(.hidden)
                .ignoresSafeArea()
        }
    }
    
}

struct DbScrollView_Previews: PreviewProvider {
    static var previews: some View {
        DbScrollView()
    }
}
