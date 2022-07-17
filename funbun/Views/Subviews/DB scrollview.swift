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
        ScrollView {
        ForEach(viewContext.currentList, id: \.id) { item in
            WardrobeItemCell(itemtitle: item.name!)
                
        }
        }.menuIndicator(.hidden)
    }
}

struct DbScrollView_Previews: PreviewProvider {
    static var previews: some View {
        DbScrollView()
    }
}
