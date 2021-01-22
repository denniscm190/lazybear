//
//  Company.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/1/21.
//

import SwiftUI

struct Company: View {
    
    var body: some View {
        CompanyHeader()
        ScrollView {
            VStack(alignment: .leading) {
                Price()
                Spacer()
            }
        }
    }
}

struct Company_Previews: PreviewProvider {
    static var previews: some View {
        Company()
    }
}
