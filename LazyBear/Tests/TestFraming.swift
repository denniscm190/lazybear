//
//  TestFraming.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 29/3/21.
//

import SwiftUI

struct TestFraming: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
            
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color.blue)
                    .frame(height: 100)
                    .overlay(
                        LineView()
                    )
            }
            .padding(.bottom)
        }
    }
}

struct TestFraming_Previews: PreviewProvider {
    static var previews: some View {
        TestFraming()
    }
}
