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
    @State var OffsetX = CGFloat(0)
    
    var body: some View {
        
        HStack {
                itemimage.padding()
                Spacer()
                Text(itemtitle).padding(.trailing, 75)
            }.background(content: {Rectangle().frame(width: 250, height: 75, alignment: .top).foregroundColor(.gray).cornerRadius(25)})
            
            .frame(width: 250, height: 75, alignment: .center)
            .offset(x: OffsetX, y: 0)
            .gesture(DragGesture(minimumDistance: 1, coordinateSpace: .local)
                .onChanged({ gesture in
                    OffsetX = gesture.translation.width
                    print(gesture.translation.width)

                            }
                          )
                    .onEnded({finished in
                        withAnimation(.spring()) {
                            OffsetX = 0}
                        
                    })
                        )
            
        
            
        
    }
}

struct WardrobeItemCell_Previews: PreviewProvider {
    static var previews: some View {
        WardrobeItemCell(itemtitle: "Debug name")
    }
}



