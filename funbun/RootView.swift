//
//  ContentView.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import SwiftUI

let userdefaults = UserDefaults()
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
                .blur(radius: ViewContext.showsheet ? 5 : 0)
        case 1:
            DataBaseView()
                .onAppear(perform: {changingviews.toggle()})
                .blur(radius: ViewContext.showsheet ? 5 : 0)
        case 2:
            DebugView()
                .blur(radius: ViewContext.showsheet ? 5 : 0)
        case 10:
            AddItemForm()
                
        default: EmptyView()
                                        }
            if changingviews {
                ProgressView().progressViewStyle(.circular).task {
                   await ViewContext.UpdateList()
                    changingviews.toggle()
                }
            } else {
                /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/
            }
                }
            if ViewContext.showsheet {
                AddItemForm()
                    .frame(width: ScreenWidth - 100, height: ScreenHeight-150, alignment: .center)
                    .cornerRadius(15)
                    .foregroundColor(.black)
                    .gesture(DragGesture(minimumDistance: 2, coordinateSpace: .global)
                        .onEnded({ gesture in
                            if ViewContext.IsInDissmiss {
                                
                            } else {
                                ViewContext.IsInDissmiss = true
                                withAnimation(.spring(), {ViewContext.showsheet.toggle()})
                                ViewContext.IsInDissmiss.toggle()
                                
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
