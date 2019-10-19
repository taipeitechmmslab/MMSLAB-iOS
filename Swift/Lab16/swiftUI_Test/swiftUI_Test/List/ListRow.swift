//
//  ListRow.swift
//  swiftUI_Test
//
//  Created by 張力元 on 2019/10/14.
//  Copyright © 2019 張力元. All rights reserved.
//

import SwiftUI

struct ListRow: View {
    var title : String = "Title"
    var subtitle : String = "sutitle"
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.title)
                .foregroundColor(Color.red)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(Color.green)
        }
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow()
    }
}
