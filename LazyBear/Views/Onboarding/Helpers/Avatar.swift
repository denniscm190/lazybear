//
//  Avatar.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 26/3/21.
//

import SwiftUI

struct Avatar: View {
    var scaleMultipler: CGFloat
    var backgroundHeight: CGFloat
    @EnvironmentObject var environmentSignUp: EnvironmentSignUp
    
    var body: some View {
        environmentSignUp.background
            .clipShape(Circle())
            .frame(maxWidth: backgroundHeight + 50, maxHeight: backgroundHeight)
            .overlay(
                Image("Head")
                    .scaleEffect(scaleMultipler)
                    .colorMultiply(environmentSignUp.skinTone)
            )
            .overlay(
                ZStack {
                    Image(environmentSignUp.hair)
                        .scaleEffect(scaleMultipler)
                        .offset(y: -5*scaleMultipler)
                        .colorMultiply(environmentSignUp.hairColor)
                    
                    Image(environmentSignUp.nose)
                        .scaleEffect(scaleMultipler)
                    
                    Image(environmentSignUp.eyes)
                        .scaleEffect(scaleMultipler)
                        .offset(y: -5*scaleMultipler)
                    
                    Image(environmentSignUp.mouth)
                        .scaleEffect(scaleMultipler)
                        .offset(y: 5*scaleMultipler)
                    
                    Image(environmentSignUp.body)
                        .scaleEffect(scaleMultipler)
                        .offset(y: 19*scaleMultipler)
                        .colorMultiply(environmentSignUp.bodyColor)
                }
            )
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar(scaleMultipler: 2, backgroundHeight: 100)
    }
}
