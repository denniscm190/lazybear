//
//  HistoryPlaceholder.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 8/2/21.
//

import SwiftUI

/*
 Placeholder when some lists are empty, such as HistoryList and WachtList
 */

struct Placeholder: View {
    @State var title: String
    @State var text: String?
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
            Text(text ?? "")
        }
        .font(.body)
        .opacity(0.5)
    }
}

struct HistoryPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        Placeholder(title: "Try to search something!", text: "For example, type 'Apple' in the search bar")
    }
}
