//
//  WardrobeItemCell.swift
//  funbun
//
//  Created by william Vise on 13/7/2022.
//

import SwiftUI

struct WardrobeItemCell: View {
    var itemtitle: String
    var cellid: UUID
    var itemimage = Image(systemName: "tshirt")
    @StateObject var viewContext = globalcontext
    @State var deleteicon = false
    @State var offsetX = CGFloat(0)
    @State var deleteOffset = false
    @State var rotationOffset = 90.0
    @State var iconOpacity = 0.0
    @State var deleteConfirmation = false
    var body: some View {
        HStack {
            Rectangle().frame(width: 1, height: 65, alignment: .trailing).foregroundColor(.clear).padding(.trailing, 60)
            HStack {
                itemimage
                Text(itemtitle).lineLimit(2).padding(.trailing, 0)
                    .multilineTextAlignment(.center)
                    .frame(width: 150, height: 75, alignment: .center)
                    }.background(content: {
                             Rectangle()
                            .frame(width: 250, height: 75, alignment: .trailing)
                            .foregroundColor(GlobalContext.cellBackground)
                            .cornerRadius(25)
                            })
                    .frame(width: 250, height: 75, alignment: .center)
                    .offset(x: offsetX, y: 0)
                    .gesture(DragGesture(minimumDistance: 1, coordinateSpace: .local)
                    .onChanged({ gesture in
                        if gesture.translation.width <= 11 {offsetX = gesture.translation.width
                            if rotationOffset >= 0 {
                            }
                        }
                        if deleteOffset {
                            offsetX = -100
                            withAnimation(.easeInOut) {rotationOffset = 0 }
                        }
                            }
                              )
                        .onEnded({ _ in

                            if offsetX < -100 {
                                withAnimation(.easeInOut) {rotationOffset = 0}
                                withAnimation(.spring()) {
                                offsetX = -100
                                deleteicon = true
                                deleteOffset = true
                                }
                                withAnimation(.easeOut) {
                                    iconOpacity = 1
                                }

                            } else {
                            withAnimation(.spring()) {
                                offsetX = 0
                                deleteicon = false
                                deleteOffset = false
                            }
                                withAnimation(.easeOut) {
                                    iconOpacity = 0
                                    rotationOffset = 90
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
                .gesture(TapGesture().onEnded({ _ in
                    deleteConfirmation.toggle()
                    
                }))
            if deleteConfirmation {ProgressView().progressViewStyle(.circular).task {
                await viewContext.removeFromList(cellid: cellid)
                await viewContext.updateList()
                deleteConfirmation.toggle()
                
            }
            }
            
        }
    }
}

struct WardrobeItemCell_Previews: PreviewProvider {
    static var previews: some View {
        WardrobeItemCell(itemtitle: "Debug name", cellid: UUID())
    }
}
