//
//  CircleImage.swift
//  swiftUI_Test
//
//  Created by 張力元 on 2019/10/14.
//  Copyright © 2019 張力元. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var imgName : String = "Cubee"
    var frameColor : Color = .blue
    var lineWidth : CGFloat = 5
    var body: some View {
        VStack {
            Image(imgName)
                .clipShape(Circle())
                .overlay(Circle().stroke(frameColor ,lineWidth: lineWidth))
                .shadow(radius: 10)
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
