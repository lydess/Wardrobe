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
    
    var body: some View {
    
        VStack {
            Spacer()
            ForEach(ViewContext.examplelist, id: \.id) { item in
                    Text(item.name!)
            }
            Spacer()
            HStack {
                Button("add DB item"){DataHandler.addnewitem()
                    AddItemIndicator.toggle()
                }
                Button("Delete DB item"){
                    DeleteItemIndicator.toggle()
                }
            }.padding(.bottom, 50)
            
            
            if AddItemIndicator {ProgressView().progressViewStyle(.circular).task {
                ViewContext.examplelist = await DataHandler.GetDBItems()
                AddItemIndicator.toggle()
            }}
            
            if DeleteItemIndicator {ProgressView().progressViewStyle(.circular).task {
                await DataHandler.removetopitem()
                ViewContext.examplelist = await DataHandler.GetDBItems()
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
