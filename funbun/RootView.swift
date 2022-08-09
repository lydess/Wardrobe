//
//  ContentView.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import SwiftUI

let userdefaults = UserDefaults()
var globalcontext = GlobalContext()
var dataHandler = DataBase()
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let keyboardwillshow = NotificationCenter.default
    .publisher(for: UIResponder.keyboardWillShowNotification)
let keyboardwillhide = NotificationCenter.default
    .publisher(for: UIResponder.keyboardWillHideNotification)


struct RootView: View {
    @State var keyboardisshown = false
    @StateObject var viewContext = globalcontext
    @State var changingviews = false
    var body: some View {
        ZStack {
        VStack {
        Spacer()
            if keyboardisshown {
                EmptyView().onReceive(keyboardwillhide, perform: {_ in
                    keyboardisshown = false
                    print("showing nav bar")
                })
            } else {
                NavBar()
                    .onReceive(keyboardwillshow, perform: {_ in
                    keyboardisshown = true
                    print("hiding nav bar")
                })
                    
            }
        }
        VStack {
        switch viewContext.currentScreen {
        case 0:
            HomeView()
                .blur(radius: viewContext.showsheet ? 5 : 0)
        case 1:
            DataBaseView()
                .onAppear(perform: {changingviews.toggle()})
                .blur(radius: viewContext.showsheet ? 5 : 0)
        case 2:
            DebugView(testimg: Image(systemName: "Circle"))
                .blur(radius: viewContext.showsheet ? 5 : 0)
        case 10:
            AddItemForm()
        case 11:
            CameraView()
        case 15:
            ItemDetailView()
            
        default: Text("Broken Screen Number")
        }
            if changingviews {
                ProgressView().progressViewStyle(.circular).task {
                   await viewContext.updateList()
                    changingviews.toggle()
                }
            }
                }
            if viewContext.showsheet && viewContext.cameraisshown == false {
                
                ZStack {
                    HStack {
                        Spacer().frame(width: 10, height: 10, alignment: .center)
                        AddItemForm()
                            .cornerRadius(15)
                            .foregroundColor(.black)
                            Spacer().frame(width: 10, height: 10, alignment: .center)
                            
                    }
                }
                    
                    
            }
                }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        RootView()
    }
}
