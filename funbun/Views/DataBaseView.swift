//
//  DataBaseView.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import SwiftUI

struct DataBaseView: View {
    @StateObject var viewContext = globalcontext
    @State var addItemIndicator = false
    @State var deleteItemIndicator = false
    @State var offsetX = CGFloat(0)
    @State var showAddItem = false
    
    var body: some View {
    
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.easeIn, {viewContext.showsheet.toggle()})},
                       label: {
                    Image(systemName: "plus")
                })
                
               
            }.padding([.top, .trailing], 25)
            
            
            Spacer()
            DbScrollView()
            
            Spacer()
            
            if addItemIndicator {ProgressView().progressViewStyle(.circular).task {
                await viewContext.updateList()
                addItemIndicator.toggle()
            }}
            
            if deleteItemIndicator {ProgressView().progressViewStyle(.circular).task {
                await dataHandler.removetopitem()
                await viewContext.updateList()
                deleteItemIndicator.toggle()
            }}
        }
        
    }
}

struct DataBaseView_Previews: PreviewProvider {
    static var previews: some View {
        DataBaseView()
    }
}
