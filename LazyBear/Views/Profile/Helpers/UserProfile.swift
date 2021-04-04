//
//  UserProfile.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 4/4/21.
//

import SwiftUI

struct UserProfile: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var userImage = Image("")
    
    var body: some View {
        VStack {
            Circle()
                .frame(width: 200, height: 200)
                .overlay(
                    userImage
                        .resizable()
                        .clipShape(Circle())

                )
                .onTapGesture { self.showingImagePicker = true }

        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        userImage = Image(uiImage: inputImage)

    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}
