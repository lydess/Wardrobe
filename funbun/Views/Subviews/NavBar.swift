//
//  NavBar.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import SwiftUI

struct NavBar: View {
    @StateObject var viewContext = globalcontext
    var buttsize = CGFloat(25)
    var body: some View {
        VStack {          
            HStack {
                Spacer()
                Button(action: {viewContext.currentScreen = 0}, label: {Image(systemName: "house")
                    .resizable()
                    .frame(width: buttsize, height: buttsize, alignment: .center)})
                Spacer()
                Button(action: {viewContext.currentScreen = 1}, label: {Image(systemName: "list.bullet")
                    .resizable()
                    .frame(width: buttsize, height: buttsize, alignment: .center)})
                Spacer()
                Button(action: {viewContext.currentScreen = 2}, label: {Image(systemName: "info.circle")
                    .resizable()
                    .frame(width: buttsize, height: buttsize, alignment: .center)})
                Spacer()
            }
        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
