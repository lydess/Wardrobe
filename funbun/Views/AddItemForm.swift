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
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .frame(width: ScreenWidth-100, height: ScreenHeight - 150, alignment: .center)
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
                        var UserFormInput = FormInput(type: .InventoryItem)
                            UserFormInput.Name = NameTextField
                            UserFormInput.date = Datechosen
                            UserFormInput.id = UUID()
                            DataHandler.AddForm(form: UserFormInput)
                            indicator.toggle()
                            
                }
                .padding(.top, 50)
                
                .buttonStyle(.borderedProminent)
                    
                    if indicator {
                        ProgressView().progressViewStyle(.circular).task {
                            await DataHandler.GetDBItems()
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
