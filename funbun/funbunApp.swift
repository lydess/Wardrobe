//
//  funbunApp.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import SwiftUI

@main

struct FunbunApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var datamanager = dataHandler
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, datamanager.context.viewContext)
                .background(GlobalContext.rootbackground)
                
        }.onChange(of: scenePhase, perform: { phase in
            if phase == .background {print("hiding away")}
            if phase == .active {print("hello im back")}
            if phase == .inactive {print("sleep mode activated")}
        })
    }
}
