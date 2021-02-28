//
//  TestPullScroll.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/2/21.
//

import SwiftUI

struct TestPullScroll: View {
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach((1...10), id: \.self) {
                    Text("Row \($0)")
                    Divider()
                }
            }
        }
    }
    
    func action() {
        print("Action")
    }
}

struct Row: View {
    var body: some View {
        Text("Hello row")
    }
}

struct TestPullScroll_Previews: PreviewProvider {
    static var previews: some View {
        TestPullScroll()
    }
}
