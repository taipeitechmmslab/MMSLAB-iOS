//
//  ListView.swift
//  swiftUI_Test
//
//  Created by 張力元 on 2019/10/14.
//  Copyright © 2019 張力元. All rights reserved.
//

import SwiftUI

struct ListView: View {
    var body: some View {
        List{
            ListRow(title: "聖誕快樂", subtitle: "Merry Christmas! ")
            ListRow(title: "敬祝聖誕，恭賀新喜", subtitle: "Merry Christmas and a happy new year. ")
            ListRow(title: "獻上最誠摯的節日祝福", subtitle: "Best wishes on this holiday season. ")
            ListRow(title: "值此佳節，祝你全家聖誕快樂", subtitle: "Wishing you and yours a merry Christmas this holiday season. ")
            ListRow(title: "我們祝你聖誕快樂", subtitle: "We wish you a merry Christma")
            ListRow(title: "節日愉快", subtitle: "Wishing you a beautiful holiday season. ")
            ListRow(title: "順頌時祺", subtitle: "Season's greetings. ")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
