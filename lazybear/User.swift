//
//  User.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/12/20.
//

import SwiftUI

struct User: View {
    @Environment(\.presentationMode) var userPresentation
    
    var body: some View {
        VStack(alignment:.leading) {
            HStack {
                Button(action: {self.userPresentation.wrappedValue.dismiss()
                }) {
                    Image(systemName: "multiply")
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Spacer()
                }
            }
            
            Text("My favourites")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            List {
                HStack {
                    Image(systemName: "star")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Text("Company 1")
                }
            }
        }
        .padding()
    }
}

struct User_Previews: PreviewProvider {
    static var previews: some View {
        User()
    }
}
