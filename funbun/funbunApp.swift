//
//  funbunApp.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import SwiftUI

@main

struct funbunApp: App {
    @StateObject var datamanager = DataHandler
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, datamanager.context.viewContext)
        }
    }
}
