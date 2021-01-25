//
//  TestViewBuilder.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/1/21.
//

import SwiftUI

struct TestViewBuilder: View {
    @State var condition = true
    var body: some View {
        VStack {
            Text("Line 1")
            Text("Line 2")
        }
        .if(condition) { content in
            ScrollView(.vertical) { content }
        }
    }
}
extension View {
   @ViewBuilder
   func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}

struct TestViewBuilder_Previews: PreviewProvider {
    static var previews: some View {
        TestViewBuilder()
    }
}
