//
//  DataBaseView.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import SwiftUI

struct DataBaseView: View {
    @StateObject var ViewContext = Globalcontext
    @State var AddItemIndicator = false
    @State var DeleteItemIndicator = false
    @State var OffsetX = CGFloat(0)
    @State var ShowAddItem = false
    
    var body: some View {
    
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.easeIn, {ViewContext.showsheet.toggle()})},
                       label: {
                    Image(systemName: "plus")
                })
                
               
            }.padding([.top, .trailing], 25)
            
            
            Spacer()
            DB_scrollview()
            
            Spacer()
            
            if AddItemIndicator {ProgressView().progressViewStyle(.circular).task {
                await ViewContext.UpdateList()
                AddItemIndicator.toggle()
            }}
            
            if DeleteItemIndicator {ProgressView().progressViewStyle(.circular).task {
                await DataHandler.removetopitem()
                await ViewContext.UpdateList()
                DeleteItemIndicator.toggle()
            }}
        }
        
    }
}

struct DataBaseView_Previews: PreviewProvider {
    static var previews: some View {
        DataBaseView()
    }
}
