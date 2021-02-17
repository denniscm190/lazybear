//
//  Row.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 17/2/21.
//

import SwiftUI

struct Row: View {
    @State var baseText: String
    @State var underText: String?
    
    @State var leftView: AnyView?
    @State var rightView: AnyView?
    
    var body: some View {
        HStack {
            leftView
            VStack {
                Text(baseText)
                Text(underText ?? "")
            }
            
            Spacer()
            rightView
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row(baseText: "Some text")
    }
}
