//
//  ContentView.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import SwiftUI


var Globalcontext = GlobalContext()
var DataHandler = Database()
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
struct RootView: View {
    
    @StateObject var ViewContext = Globalcontext
    @State var changingviews = false
    var body: some View {
        ZStack  {
        VStack{
        Spacer()
        NavBar()
        }
        VStack  {
        switch ViewContext.CurrentScreen {
        case 0:
            HomeView()
        case 1:
            DataBaseView().onAppear(perform: {changingviews.toggle()})
        case 2:
            DebugView()
        case 10:
            AddItemForm()
        default: EmptyView()
                                        }
            if changingviews {
                ProgressView().progressViewStyle(.circular).task {
                   await ViewContext.UpdateList()
                }
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
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
