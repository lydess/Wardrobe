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
    @State var Deleteicon = false
    @State var OffsetX = CGFloat(0)
    @State var DeleteOffset = false
    @State var RotationOffset = 90.0
    @State var IconOpacity = 1.0
 
    
    
    var body: some View {
        
        HStack {
            Rectangle().frame(width: 1, height: 65, alignment: .trailing).foregroundColor(.clear).padding(.trailing, 60)
          
            
            HStack {
                itemimage
                    
                Text(itemtitle).lineLimit(2).padding(.trailing, 0).multilineTextAlignment(.center).frame(width: 150, height: 75, alignment: .center)
                
                }.background(content: {Rectangle().frame(width: 250, height: 75, alignment: .trailing).foregroundColor(.gray).cornerRadius(25)})
                
                .frame(width: 250, height: 75, alignment: .center)
                .offset(x: OffsetX, y: 0)
                .gesture(DragGesture(minimumDistance: 1, coordinateSpace: .local)
                    
                    .onChanged({ gesture in
                        if gesture.translation.width <= 25 {OffsetX = gesture.translation.width
                            if RotationOffset >= 0 {
                                withAnimation(.spring()) {
                                    RotationOffset = gesture.translation.width / 2
                                   
                                }
                            
                                
                                
                            }
                        }
                        
                        if DeleteOffset {OffsetX = -100
                            DeleteOffset = false
                            RotationOffset = -90
                        }
                        print(RotationOffset)
                       
                        
                        

                                }
                              )
                        .onEnded({finished in
                            
                            if OffsetX < -100 {
                                withAnimation(.spring()) {
                                    OffsetX = -100}
                                //RotationOffset = 90
                                Deleteicon.toggle()
                                DeleteOffset.toggle()
                                
                                
                            } else {
                            withAnimation(.spring()) {
                                OffsetX = 0}
                            }
                            
                            if DeleteOffset == false {
                                withAnimation(.spring()) {
                                    RotationOffset = 0
                                   
                                }
                            }
                            
                        })
            )
            Image(systemName: "minus.circle")
                .resizable()
                .frame(width: 35, height: 35, alignment: .center)
                .foregroundColor(.red)
                .rotationEffect(.degrees(RotationOffset))
                .opacity(IconOpacity)
                
                
                
                
        }
            
        
            
        
    }
}

struct WardrobeItemCell_Previews: PreviewProvider {
    static var previews: some View {
        WardrobeItemCell(itemtitle: "Debug name")
    }
}



