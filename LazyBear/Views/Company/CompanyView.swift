//
//  CompanyView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 20/6/21.
//

import SwiftUI

struct CompanyView: View {
    @ObservedObject var company = Company()
    
    var body: some View {
        NavigationView {
            VStack {
                RowShape()
            }
        }
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyView()
    }
}
