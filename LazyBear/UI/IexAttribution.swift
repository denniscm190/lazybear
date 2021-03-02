//
//  IexAttribution.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 2/3/21.
//

import SwiftUI

struct IexAttribution: View {
    var text: String
    
    var body: some View {
        Link(destination: URL(string: "https://iexcloud.io")!) {
            Text(text)
                .font(.caption)
                .opacity(0.6)
                
        }
    }
}

struct IexAttribution_Previews: PreviewProvider {
    static var previews: some View {
        IexAttribution(text: "IEX Cloud")
    }
}
