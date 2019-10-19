//
//  ContentView.swift
//  swiftUI_Test
//
//  Created by 張力元 on 2019/10/10.
//  Copyright © 2019 張力元. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MapView()
                .frame(height:250)
                .edgesIgnoringSafeArea(.top)
            CircleImage(frameColor:.red)
                .offset(y:-150)
                .padding(.bottom,-150)
            NameLabel(name: "Cubee", company: "BlueNet交通大平台", title: "吉祥物")
                .padding(.bottom,-10)
            ListView()
                .padding(.bottom)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 
