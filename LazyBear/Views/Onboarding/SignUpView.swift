//
//  SignUpView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/3/21.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.managedObjectContext) private var moc
    @EnvironmentObject var environmentSignUp: EnvironmentSignUp
    @State private var showingAvatars = false
    @State private var usernameIsEmptyAlert = false
    @State private var showContentView = false
    
    var body: some View {
        if showContentView {
            ContentView()
        } else {
            GeometryReader { geo in
                NavigationView {
                    VStack(alignment: .leading) {
                        ProfileAvatar(size: geo.size.height * 0.3, showingAvatars: $showingAvatars)
                            .padding(.bottom)
                            
                        UserNameTextfield(username: $environmentSignUp.username)
                            .padding(.bottom)
                        
                        Button(action: {checkAndSave()}) {
                            NextButton(text: "Continue")
                                .padding(.bottom, 50)
                        }
                    }
                    .padding()
                    .navigationTitle("Sign Up")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .alert(isPresented: $usernameIsEmptyAlert) {
                Alert(title: Text("Select a username"), message: Text("Need ideas? Try Stockmaster, or Financial lover"), dismissButton: .default(Text("Got it!")))
            }
            .sheet(isPresented: $showingAvatars) {
                ListAvatarHelper()
            }
        }
    }
    
    private func checkAndSave() {
        if environmentSignUp.username.isEmpty {
            self.usernameIsEmptyAlert = true
        } else {
            // Save settings to CLOUDKIT and show ContentView
            let userSettings = UserSettings(context: moc)
            userSettings.avatar = environmentSignUp.avatar
            userSettings.username = environmentSignUp.username
            do {
                try moc.save()
                print("User saved")
                self.showContentView = true
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(EnvironmentSignUp())
    }
}

struct ProfileAvatar: View {
    @EnvironmentObject var environmentSignUp: EnvironmentSignUp
    @State var size: CGFloat
    @Binding var showingAvatars: Bool
    
    var body: some View {
        HStack {
            Spacer()
            ZStack(alignment: .topTrailing) {
                Image(environmentSignUp.avatar)
                    .resizable()
                    .frame(maxWidth: size, maxHeight: size)
                    .scaledToFit()
                    .clipShape(Circle())
                    .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0.0, y: 0.0)
                
                if !environmentSignUp.hideAvatarSelector {
                    Button(action: { self.showingAvatars = true }) {
                        Image(systemName: "photo")
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                Circle()
                                    .foregroundColor(Color("default"))
                                    .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0.0, y: 0.0)
                            )
                            .padding()
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct UserNameTextfield: View {
    @EnvironmentObject var environmentSignUp: EnvironmentSignUp
    @Binding var username: String
    
    var body: some View {
        VStack {
            TextField("Username", text: $username) { isEditing in
                if isEditing {  // If it's true
                    environmentSignUp.hideAvatarSelector = isEditing
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        environmentSignUp.hideAvatarSelector = isEditing
                    }
                }
            }
            .padding(10)
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
