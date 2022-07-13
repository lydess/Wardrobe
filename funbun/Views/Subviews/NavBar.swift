//
//  NavBar.swift
//  funbun
//
//  Created by william Vise on 12/7/2022.
//

import SwiftUI

struct NavBar: View {
    @StateObject var ViewContext = Globalcontext
    var body: some View {
        
        VStack{
            
            HStack {
                Spacer()
                Button(action: {ViewContext.CurrentScreen = 0}, label: {Image(systemName: "house.fill")})
                Spacer()
                Button(action: {ViewContext.CurrentScreen = 1}, label: {Image(systemName: "list.bullet")})
                Spacer()
                Button(action: {ViewContext.CurrentScreen = 2}, label: {Image(systemName: "info.circle.fill")})
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
