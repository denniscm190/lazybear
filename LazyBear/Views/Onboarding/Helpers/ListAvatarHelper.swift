//
//  ListAvatarHelper.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/3/21.
//

import SwiftUI

struct ListAvatarHelper: View {
    @EnvironmentObject var environmentSignUp: EnvironmentSignUp
    @Environment(\.presentationMode) var listAvatarPresentation
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach((1..<11), id: \.self) { index in
                        let avatar = "random\(index)"
                        Button(action: {
                            environmentSignUp.avatar = avatar
                            listAvatarPresentation.wrappedValue.dismiss()
                        }) {
                            Image(avatar)
                                .imageAvatarModifier()
                        }
                    }
                }
                Text("You can customise it later in Settings")
                    .opacity(0.6)
                    .font(.footnote)
            }
            .navigationTitle("Select Your Avatar")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ListAvatarHelper_Previews: PreviewProvider {
    static var previews: some View {
        ListAvatarHelper()
    }
}

extension Image {
    func imageAvatarModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .padding()
            .shadow(color: Color.black.opacity(0.2), radius: 10)
    }
}
