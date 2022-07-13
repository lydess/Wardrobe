//
//  WardrobeItemCell.swift
//  funbun
//
//  Created by william Vise on 13/7/2022.
//

import SwiftUI

struct WardrobeItemCell: View {
    var itemtitle: String
    var itemimage = Image(systemName: "tshirt")
    var body: some View {
        ZStack {
            Text("").background(content: {Rectangle().frame(width: 250, height: 75, alignment: .top).foregroundColor(.gray).cornerRadius(25)})
            HStack {
                itemimage.padding()
                Spacer()
                Text(itemtitle).padding(.trailing, 75)
            }.frame(width: 250, height: 75, alignment: .center)
        }
    }
}

struct WardrobeItemCell_Previews: PreviewProvider {
    static var previews: some View {
        WardrobeItemCell(itemtitle: "Debug name")
    }
}
