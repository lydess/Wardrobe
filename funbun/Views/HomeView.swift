//
//  HomeView.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import SwiftUI

struct HomeView: View {
    @StateObject var ViewContext = Globalcontext
    @State var doshowactivity = false

    var body: some View {
        VStack {
            Text("Wardobe DB Home").padding(50)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
