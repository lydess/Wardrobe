//
//  AddItemForm.swift
//  funbun
//
//  Created by william Vise on 13/7/2022.
//

import SwiftUI

struct AddItemForm: View {
    var UserFormInput = FormInput()
    @State var NameTextField = ""
    var body: some View {
        Form(content: {
            TextField("item name", text: $NameTextField)
        })
    }
}

struct AddItemForm_Previews: PreviewProvider {
    static var previews: some View {
        AddItemForm()
    }
}
