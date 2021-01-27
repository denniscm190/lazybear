//
//  LogoPlaceholder.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/1/21.
//

import SwiftUI

struct LogoPlaceholder: View {
    var placeholder: String
    var body: some View {
        let customPlaceholder = placeholder[0]
        Text(customPlaceholder)
            .fontWeight(.bold)
            .foregroundColor(Color(.systemGray))
            .frame(width: 40, height: 40)
            .background(Color(.systemGray5))
    }
}
// Index string to access it
extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

struct LogoPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        LogoPlaceholder(placeholder: "appl")
    }
}
