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
        ZStack  {
            
        VStack{
        Spacer()
        NavBar()
        }
        VStack  {
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
                
        default: EmptyView()
                                        }
            if changingviews {
                ProgressView().progressViewStyle(.circular).task {
                   await viewContext.updateList()
                    changingviews.toggle()
                }
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
            }
                }
            if viewContext.showsheet {
                AddItemForm()
                    .frame(width: screenWidth - 100, height: screenHeight-150, alignment: .center)
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .gesture(DragGesture(minimumDistance: 2, coordinateSpace: .global)
                        .onEnded({ gesture in
                            if viewContext.isInDismiss {
                                
                            } else {
                                viewContext.isInDismiss = true
                                withAnimation(.spring(), {viewContext.showsheet.toggle()})
                                viewContext.isInDismiss.toggle()
                                
                            }
                        
                })
                             
                
                )
                //AddItemForm()
                  //  .frame(width: ScreenWidth - 50, height: ScreenHeight - 100, alignment: .center).foregroundColor(.red)
                    //.cornerRadius(10)
            }
                }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
