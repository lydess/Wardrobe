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
                var itemcell = WardrobeItemCell(itemtitle: item.name!, cellid: item.id!, itemdesc: item.description)
                Button(action: {
                    viewContext.currentScreen = 15
                   },
                       label: {
                    WardrobeItemCell(itemtitle: item.name!, cellid: item.id ?? UUID(), itemdesc: "debug desc")})
                .buttonStyle(.plain)
            }
            }.menuIndicator(.hidden)
        }
    }
}

struct DbScrollView_Previews: PreviewProvider {
    static var previews: some View {
        DbScrollView()
    }
}
