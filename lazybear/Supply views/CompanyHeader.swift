//
//  CompanyHeader.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 22/1/21.
//

import SwiftUI

struct CompanyHeader: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("AAPL")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "multiply.circle.fill")
                }
                
            }
            
            Text("Apple Inc")
        }
        .padding([.leading, .trailing])
    }
}

struct CompanyHeader_Previews: PreviewProvider {
    static var previews: some View {
        CompanyHeader()
    }
}
