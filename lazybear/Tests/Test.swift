//
//  TestCloudKit.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/1/21.
//

import SwiftUI

struct Test: View {
    let cloudKit = CloudKitManager()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear {
                cloudKit.query(recordType: "API")
            }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}

