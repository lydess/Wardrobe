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
    @State var emojifield = ""
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
                
                VStack {
                    Text("Symbol:")
                    HStack {
                        SelectionView(rowContent: GlobalContext.symbolbuttons)
                    }.border(.mint)
                }.padding()
                
                
                VStack {
                    Text("Notes")
                    HStack {
                        TextField("", text: $descriptionTextfield).textFieldStyle(.roundedBorder)
                            .padding()
                        Spacer()
                    }
                }
                HStack {
                    Text("Date Added")
                        .padding()
                    Spacer()
                }
                DatePicker(selection: $datechosen, label: {})
                HStack{
                    Spacer()
                    Button(action: {viewContext.currentScreen = 10}, label: {Image(systemName: "camera")})
                    
                }
                Button("Submit") {
                        var userFormInput = FormInput(type: .inventoryItem)
                            userFormInput.name = nameTextField
                            userFormInput.date = datechosen
                            userFormInput.id = UUID()
                            userFormInput.desc = descriptionTextfield
                            userFormInput.photo = UIImage(cgImage:GlobalContext.shared.currentImage!).pngData()!
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
                
            }.padding()
                .offset(x: 0, y: -50)
        }
    }
}

struct AddItemForm_Previews: PreviewProvider {
    static var previews: some View {
        AddItemForm()
    }
}
