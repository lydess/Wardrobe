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
    @FocusState private var focusedField: Fieldfocus?
    
    enum Fieldfocus {
        case name
        case descirption
        case noneFocused
    }
    

    var body: some View {
        ScrollView {
            Spacer().frame(width: 25, height: 25, alignment: .center)
        ZStack {
            VStack {
                HStack {
                    Text("Item Name:")
                        .padding()
                    Spacer()
                    Button(action: {
                        viewContext.showsheet.toggle()},
                           label: {
                        Image(systemName: "x.circle")
                        .foregroundColor(.blue)
                        .font(.system(size: 26))
                        .offset(x: 10, y: -20)
                    })
                }
                TextField("", text: $nameTextField)
                    .textFieldStyle(.roundedBorder)
                    .submitLabel(.done)
                    .focused($focusedField, equals: .name)
                HStack {
                    Text("Notes")
                    HStack {
                        TextField("", text: $descriptionTextfield).textFieldStyle(.roundedBorder)
                            .submitLabel(.done)
                            .focused($focusedField, equals: .descirption)
                        Spacer()
                    }
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
                HStack {
                    if GlobalContext.shared.currentImage == nil {
                        
                    } else {
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
                   
                            if GlobalContext.shared.currentImage != nil {
                                userFormInput.photo = UIImage(cgImage: GlobalContext.shared.currentImage!).pngData()!
                            }
                            dataHandler.addForm(form: userFormInput)
                            indicator.toggle()
                }
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
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            print("tap")
        }
    }
    }
}

struct AddItemForm_Previews: PreviewProvider {
    static var previews: some View {
        AddItemForm()
    }
}
