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
                HStack {
                    Spacer()
                    Button(action: {
                        viewContext.currentScreen = 11
                        viewContext.cameraisshown.toggle()
                        viewContext.showsheet.toggle()
                        
                    }, label: {Image(systemName: "camera")})
                    
                    Spacer()
                }.padding()
                HStack{
                    if GlobalContext.shared.currentImage == nil {
                        
                    }else{
                        Image(uiImage: UIImage(cgImage: GlobalContext.shared.currentImage!))
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                            
                    }
                }
                Button("Submit") {
                        var userFormInput = FormInput(type: .inventoryItem)
                            userFormInput.name = nameTextField
                            userFormInput.date = datechosen
                            userFormInput.id = UUID()
                            userFormInput.desc = descriptionTextfield
                            userFormInput.photo = UIImage(cgImage: GlobalContext.shared.currentImage!).pngData()!
                            dataHandler.addForm(form: userFormInput)
                            indicator.toggle()
                }
                .padding(.top, 50)
                .buttonStyle(.borderedProminent)
                    if indicator {
                        ProgressView().progressViewStyle(.circular).task {
                            _ = await dataHandler.getDBItems()
                            await viewContext.updateList()
                            withAnimation(.easeInOut) {viewContext.showsheet.toggle()}
                            indicator.toggle()
                        }
                    }
            }.padding()
                .background(content: {Rectangle()
                        .foregroundColor(GlobalContext.cellBackground).cornerRadius(20)
                })
        }.onAppear(perform: {
            descriptionTextfield = viewContext.currentFormInput.desc
            nameTextField = viewContext.currentFormInput.name
            datechosen = viewContext.currentFormInput.date
            
        })
        .onDisappear(perform: {
            viewContext.currentFormInput.id = UUID()
            viewContext.currentFormInput.desc = descriptionTextfield
            viewContext.currentFormInput.name = nameTextField
            viewContext.currentFormInput.date = datechosen
        })
    }
}

struct AddItemForm_Previews: PreviewProvider {
    static var previews: some View {
        AddItemForm()
    }
}
