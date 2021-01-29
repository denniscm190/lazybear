//
//  Header.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/1/21.
//

import SwiftUI

struct ListHeader: View {
    var header: String
    
    var body: some View {
        HStack {
            Text(header)
                .font(.title)
                .fontWeight(.semibold)
            
            Spacer()
            EditButton()
        }
        .padding([.leading, .trailing])
    }
}

struct ListHeader_Previews: PreviewProvider {
    static var previews: some View {
        ListHeader(header: "Header")
    }
}
