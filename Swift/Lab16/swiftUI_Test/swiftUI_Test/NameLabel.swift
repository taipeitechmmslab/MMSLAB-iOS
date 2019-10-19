//
//  NameLabel.swift
//  swiftUI_Test
//
//  Created by 張力元 on 2019/10/14.
//  Copyright © 2019 張力元. All rights reserved.
//

import SwiftUI

struct NameLabel: View {
    var name : String = "姓名"
    var company : String = "公司"
    var title : String = "頭銜"
    var body: some View {
        VStack(alignment: .leading){
            Text(name)
                .font(.largeTitle)
            HStack{
                Text(company)
                    .font(.subheadline)
                Spacer()
                Text(title)
                    .font(.subheadline)
            }
        }
        .padding()
    }
}

struct NameLabel_Previews: PreviewProvider {
    static var previews: some View {
        NameLabel()
    }
}
