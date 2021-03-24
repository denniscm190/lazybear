//
//  UserHelper.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 24/3/21.
//

import SwiftUI

struct UserHelper: View {
    var body: some View {
        GeometryReader { geo in
            HStack {
                UserImage()
                    .frame(height: geo.size.height * 0.1)
                    .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Hello, Dennis!")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Text("How is the market doing today?")
                        .opacity(0.5)
                }
            }
        }
    }
}

struct UserImage: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .aspectRatio(1.0, contentMode: .fit)
            .foregroundColor(Color("default"))
            .opacity(0.3)
            .overlay(
                Image("testMemoji")
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .cornerRadius(20)
                    .padding(5)
            )
    }
}

struct UserHelper_Previews: PreviewProvider {
    static var previews: some View {
        UserHelper()
    }
}
