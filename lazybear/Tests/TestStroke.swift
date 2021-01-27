//
//  TestStroke.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/1/21.
//

import SwiftUI

struct TestStroke: View {
    var body: some View {
        Circle()
            .stroke(Color(.blue))
    }
}

struct TestStroke_Previews: PreviewProvider {
    static var previews: some View {
        TestStroke()
    }
}
