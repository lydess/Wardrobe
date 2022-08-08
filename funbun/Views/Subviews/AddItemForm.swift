//
//  AddItemForm.swift
//  funbun
//
//  Created by william Vise on 13/7/2022.
//

import SwiftUI

struct AddItemForm: View {
    @State var nameTextField = ""
    @State var descriptionTextfield = ""
    @State var datechosen = Date()
    @State var indicator = false
    @StateObject var viewContext = globalcontext

    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .frame(width: screenWidth-100, height: screenHeight - 150, alignment: .center)
                .foregroundColor(GlobalContext.cellBackground)
            }
            VStack {
                HStack {
                    Text("Item Name:")
                        .padding()
                    Spacer()
                    Button(action: {viewContext.showsheet.toggle()}, label: {Image(systemName: "x.circle")
                        .font(.system(size: 26))
                        .offset(x: 10, y: -20)
                    })
                }
                TextField("", text: $nameTextField).textFieldStyle(.roundedBorder)
                HStack{
                    Text("Symbol")
                    SelectionView(rowContent: GlobalContext.symbolbuttons)
                }
                HStack {
                    Text("Notes")
                        .padding()
                    Spacer()
                }
                
                HStack {
                    TextField("", text: $descriptionTextfield).textFieldStyle(.roundedBorder)
                        .padding()
                    Spacer()
                }
                HStack {
                    Text("Date Added")
                        .padding()
                    Spacer()
                }
                DatePicker(selection: $datechosen, label: {})
                Button("Submit") {
                        var userFormInput = FormInput(type: .inventoryItem)
                            userFormInput.name = nameTextField
                            userFormInput.date = datechosen
                            userFormInput.id = UUID()
                            userFormInput.desc = descriptionTextfield
                            dataHandler.addForm(form: userFormInput)
                            indicator.toggle()
                }
                .padding(.top, 50)
                .buttonStyle(.borderedProminent)
                    if indicator {
                        ProgressView().progressViewStyle(.circular).task {
                            await dataHandler.getDBItems()
                            await viewContext.updateList()
                            withAnimation(.easeInOut) {viewContext.showsheet.toggle()}
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
