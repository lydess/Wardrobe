//
//  HomeView.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewContext = globalcontext
    @State var doshowactivity = false

    var body: some View {
        VStack {
            Text("Wardobe DB Home").padding(50).font(.largeTitle)
            Text("Need any help getting started?")
            HStack {
                Button("Nope, i've been here before") {}.padding(.trailing, 50)
                Button("Yes please teach me") {}
            }.padding(.top, 50)
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
