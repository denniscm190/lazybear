//
//  Avatar.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 26/3/21.
//

import SwiftUI

struct Avatar: View {
    @EnvironmentObject var firstAvatar: FirstAvatar
    
    var body: some View {
        VStack {
            Image("head")
                .componentModifier()
                .overlay(
                    ZStack {
                        Image(firstAvatar.body)
                            .componentModifier()
                            .colorMultiply(Color(firstAvatar.bodyColor))

                        Image(firstAvatar.hair)
                            .componentModifier()
                            .colorMultiply(Color(firstAvatar.hairColor))
                        
                        Image(firstAvatar.eyes)
                            .componentModifier()
                        
                        Image(firstAvatar.nose)
                            .componentModifier()
                        
                        Image(firstAvatar.mouth)
                            .componentModifier()
                    }
                )
        }
        .padding()
    }
}
extension Image {
    func componentModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar()
            .environmentObject(FirstAvatar())
    }
}
