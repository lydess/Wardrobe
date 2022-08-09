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

struct RootView: View {
    @StateObject var viewContext = globalcontext
    @State var changingviews = false
    
    var body: some View {
        ZStack {
        VStack {
        Spacer()
            NavBar()
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
            DebugView()
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
                AddItemForm()
                    .frame(width: screenWidth - 100, height: screenHeight-150, alignment: .top)
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    
            }
                }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
