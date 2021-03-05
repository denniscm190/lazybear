//
//  InsidersView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 5/3/21.
//

import SwiftUI

struct InsidersView: View {
    var body: some View {
        ForEach((1...50), id: \.self) { item in
               Text("Insider view")
       }
    }
}

struct InsidersView_Previews: PreviewProvider {
    static var previews: some View {
        InsidersView()
    }
}
