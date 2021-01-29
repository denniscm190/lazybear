//
//  LogoPlaceholder.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/1/21.
//

import SwiftUI

struct LogoPlaceholder: View {
    var body: some View {
        Image(systemName: "building.2")
            .foregroundColor(Color(.systemGray))
            .frame(width: 40, height: 40)
            .background(Color(.systemGray5))
    }
}

struct LogoPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        LogoPlaceholder()
    }
}
