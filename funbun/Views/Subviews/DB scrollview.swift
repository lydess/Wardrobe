//
//  DB scrollview.swift
//  funbun
//
//  Created by william Vise on 13/7/2022.
//

import SwiftUI

struct DB_scrollview: View {
    @StateObject var ViewContext = globalcontext
    var body: some View {
        ScrollView{
        ForEach(ViewContext.currentList, id: \.id) { item in
            WardrobeItemCell(itemtitle: item.name!)
                
        }
        }.menuIndicator(.hidden)
            
        
        
    }
}

struct DB_scrollview_Previews: PreviewProvider {
    static var previews: some View {
        DB_scrollview()
    }
}
