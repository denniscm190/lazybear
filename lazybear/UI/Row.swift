//
//  Row.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 17/2/21.
//

import SwiftUI

struct Row: View {
    var baseText: String
    var underText: String?
    
    var leftView: AnyView?
    var rightView: AnyView?
    
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
