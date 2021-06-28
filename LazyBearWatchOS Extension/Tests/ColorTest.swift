//
//  ColorTest.swift
//  LazyBearWatchOS Extension
//
//  Created by Dennis Concepción Martín on 28/06/2021.
//

import SwiftUI

struct ColorTest: View {
    var body: some View {
        VStack {
            Text("Hello world")
                .foregroundColor(.red)
                .font(.title)
                .fontWeight(.black)
            
            Text("Hello world")
                .foregroundColor(Color(.red))
                .font(.title)
                .fontWeight(.black)
        }
    }
}

struct ColorTest_Previews: PreviewProvider {
    static var previews: some View {
        ColorTest()
    }
}
