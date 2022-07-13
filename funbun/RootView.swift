//
//  ContentView.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import SwiftUI


var Globalcontext = GlobalContext()
var DataHandler = Database()
struct RootView: View {
    
    @StateObject var ViewContext = Globalcontext
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
            DataBaseView()
        default: EmptyView()
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
