//
//  SignUp.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/3/21.
//

import SwiftUI

struct SignUp: View {
    @State var username: String = ""
    @State var textFieldIsEditing = false
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                Text("Sign Up")
                    .font((.system(size: 50, weight: .black)))
                    .padding(.vertical)
                
                Text("Let us customise your experience")
                    .opacity(0.5)
                    .padding(.bottom)
            
                ProfileAvatar(size: geo.size.height * 0.3, textFieldIsEditing: $textFieldIsEditing)
                    .padding(.bottom)
                    
                UserNameTextfield(username: $username, isEditing: $textFieldIsEditing)
                Spacer()
                NextButton(text: "Continue")
                    .padding(.bottom, 50)
                
                
            }
            .padding(.horizontal)
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}

struct ProfileAvatar: View {
    @State var size: CGFloat
    @Binding var textFieldIsEditing: Bool
    
    var body: some View {
        HStack {
            Spacer()
            ZStack(alignment: .topTrailing) {
                Image("boyAvatar")
                    .resizable()
                    .frame(maxWidth: size, maxHeight: size)
                    .scaledToFit()
                    .clipShape(Circle())
                
                if !textFieldIsEditing {
                    Image(systemName: "photo")
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            Circle()
                                .foregroundColor(Color("default"))
                        )
                        .padding()
                }
            }
            
            Spacer()
        }
    }
}

struct UserNameTextfield: View {
    @Binding var username: String
    @Binding var isEditing: Bool
    
    var body: some View {
        VStack {
        Text("Your username")
            .font(.headline)
        
            TextField("Username", text: $username) { isEditing in
                self.isEditing = isEditing
            } onCommit: {
                print(username)
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(.systemGray6))
            )
        }
    }
}

struct NextButton: View {
    var text: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundColor(Color("default"))
            .frame(height: 50)
            .overlay(
            Text(text)
                .foregroundColor(.white)
            )
    }
}
