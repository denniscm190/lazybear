//
//  RevenueCatTest.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 13/6/21.
//

import SwiftUI
import Purchases

struct RevenueCatTest: View {
    var body: some View {
        Text("Hello world")
            .onAppear { showOfferings() }
    }
    
    private func showOfferings() {
        Purchases.shared.offerings { (offerings, error) in
            if let offerings = offerings {
              // Display current offering with offerings.current
                print(offerings.current as Any)
                print("dennis")
          }
        }
    }
}

struct RevenueCatTest_Previews: PreviewProvider {
    static var previews: some View {
        RevenueCatTest()
    }
}
