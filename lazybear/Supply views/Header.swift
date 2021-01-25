//
//  Header.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/1/21.
//

import SwiftUI

struct Header: View {
    @State var name: String
    
    var body: some View {
        Text(name)
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(name: "Home")
    }
}
