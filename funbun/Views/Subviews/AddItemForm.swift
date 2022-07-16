//
//  AddItemForm.swift
//  funbun
//
//  Created by william Vise on 13/7/2022.
//

import SwiftUI

struct AddItemForm: View {
   
    
    @State var NameTextField = ""
    @State var Datechosen = Date()
    @State var indicator = false
    @StateObject var ViewContext = globalcontext
    
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
                TextField("", text: $NameTextField).textFieldStyle(.roundedBorder)
                HStack {
                    Text("Date Added")
                        .padding()
                    Spacer()
                }
                DatePicker(selection: $Datechosen, label: {})
                Button("Submit"){
                        var UserFormInput = FormInput(type: .inventoryItem)
                            UserFormInput.name = NameTextField
                            UserFormInput.date = Datechosen
                            UserFormInput.id = UUID()
                            dataHandler.AddForm(form: UserFormInput)
                            
                            indicator.toggle()
                            
                }
                .padding(.top, 50)
                
                .buttonStyle(.borderedProminent)
                    
                    if indicator {
                        ProgressView().progressViewStyle(.circular).task {
                            await dataHandler.GetDBItems()
                            await ViewContext.updateList()
                            withAnimation(.easeInOut){ViewContext.showsheet.toggle()}
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
