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
                .onAppear(perform: {
    #if Dev_env
                    print("executing in DEV Configuration")
    #else
                    print("executing in PROD Configuration")
    #endif
                })
            
        }.onChange(of: scenePhase, perform: { phase in
            if phase == .background {print("Entering Background")}
            if phase == .active {print("Becoming Active")}
            if phase == .inactive {print("Entering Inactive State")}
        })
    }
}
