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
        Form(content: {
            Section{
            TextField("item name", text: $NameTextField)
                DatePicker("Date added", selection: $Datechosen)
            }
            Section{
                Button("Submit"){
                    var UserFormInput = FormInput(type: .InventoryItem)
                        UserFormInput.Name = NameTextField
                        UserFormInput.date = Datechosen
                        UserFormInput.id = UUID()
                        DataHandler.AddForm(form: UserFormInput)
                        indicator.toggle()
                        
                }
                
                if indicator {
                    ProgressView().progressViewStyle(.circular).task {
                        
                        await DataHandler.GetDBItems()
                        indicator.toggle()
                    }
                }
            }
            })
    }
}

struct AddItemForm_Previews: PreviewProvider {
    static var previews: some View {
        AddItemForm()
    }
}
