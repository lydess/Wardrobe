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
    @State var deleteicon = false
    @State var offsetX = CGFloat(0)
    @State var deleteOffset = false
    @State var rotationOffset = 90.0
    @State var iconOpacity = 1.0
 
    
    
    var body: some View {
        
        HStack {
            Rectangle().frame(width: 1, height: 65, alignment: .trailing).foregroundColor(.clear).padding(.trailing, 60)
          
            
            HStack {
                itemimage
                    
                Text(itemtitle).lineLimit(2).padding(.trailing, 0).multilineTextAlignment(.center).frame(width: 150, height: 75, alignment: .center)
                
            }.background(content: {Rectangle().frame(width: 250, height: 75, alignment: .trailing).foregroundColor(GlobalContext.CellBackground).cornerRadius(25)})
                
                .frame(width: 250, height: 75, alignment: .center)
                .offset(x: offsetX, y: 0)
                .gesture(DragGesture(minimumDistance: 1, coordinateSpace: .local)
                    
                    .onChanged({ gesture in
                        if gesture.translation.width <= 11 {offsetX = gesture.translation.width
                            if rotationOffset >= 0 {
                                withAnimation(.spring()) {
                                    rotationOffset = gesture.translation.width / 2
                                   
                                }
                            
                                
                                
                            }
                        }
                        
                        if deleteOffset {offsetX = -100
                            deleteOffset = false
                            rotationOffset = -90
                        }
                        print(rotationOffset)
                       
                        
                        

                                }
                              )
                        .onEnded({finished in
                            
                            if offsetX < -100 {
                                withAnimation(.spring()) {
                                    offsetX = -100}
                                //RotationOffset = 90
                                deleteicon.toggle()
                                deleteOffset.toggle()
                                
                                
                            } else {
                            withAnimation(.spring()) {
                                offsetX = 0}
                            }
                            
                            if deleteOffset == false {
                                withAnimation(.spring()) {
                                    rotationOffset = 0
                                   
                                }
                            }
                            
                        })
            )
            Image(systemName: "minus.circle")
                .resizable()
                .frame(width: 35, height: 35, alignment: .center)
                .foregroundColor(.red)
                .rotationEffect(.degrees(rotationOffset))
                .opacity(iconOpacity)
                
                
                
                
        }
            
        
            
        
    }
}

struct WardrobeItemCell_Previews: PreviewProvider {
    static var previews: some View {
        WardrobeItemCell(itemtitle: "Debug name")
    }
}



