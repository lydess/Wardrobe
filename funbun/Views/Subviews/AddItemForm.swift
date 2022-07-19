//
//  AddItemForm.swift
//  funbun
//
//  Created by william Vise on 13/7/2022.
//

import SwiftUI

struct AddItemForm: View {
   

    @State var nameTextField = ""
    @State var datechosen = Date()
    @State var indicator = false
    @StateObject var viewContext = globalcontext

    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .frame(width: screenWidth-100, height: screenHeight - 150, alignment: .center)
                .foregroundColor(GlobalContext.CellBackground)
                
            }
                
            VStack{
                HStack {
                    Text("Item Name:")
                        .padding()
                    Spacer()
                }
                TextField("", text: $nameTextField).textFieldStyle(.roundedBorder)
                HStack {
                    Text("Date Added")
                        .padding()
                    Spacer()
                }
                DatePicker(selection: $datechosen, label: {})
                Button("Submit"){
                        var userFormInput = FormInput(type: .inventoryItem)
                            userFormInput.name = nameTextField
                            userFormInput.date = datechosen
                            userFormInput.id = UUID()
                            dataHandler.addForm(form: userFormInput)
                            
                            indicator.toggle()
                            
                }
                .padding(.top, 50)
                
                .buttonStyle(.borderedProminent)
                    
                    if indicator {
                        ProgressView().progressViewStyle(.circular).task {
                            await dataHandler.getDBItems()
                            await viewContext.updateList()
                            withAnimation(.easeInOut){viewContext.showsheet.toggle()}
                            indicator.toggle()
                            
                        }
                    }
                Spacer()
            
                
            }.padding()
        }
    }
}

struct AddItemForm_Previews: PreviewProvider {
    
    static var previews: some View {
        AddItemForm()
        
    }
}
