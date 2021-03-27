//
//  SignUpView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/3/21.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.managedObjectContext) private var moc
    @EnvironmentObject var firstAvatar: FirstAvatar
    @EnvironmentObject var hapticsManager: HapticsManager
    @State private var showingAvatarGenerator = false
    @State private var usernameIsEmptyAlert = false
    @State private var showContentView = false
    
    var body: some View {
        if showContentView {
            ContentView()
        } else {
            NavigationView {
                VStack(alignment: .leading) {
                    ProfileAvatar(showingAvatarGenerator: $showingAvatarGenerator)
                        .padding(.bottom)
                    
                    UserNameTextfield(username: $firstAvatar.username)
                        .padding(.bottom)
                    
                    Spacer()
                    Button(action: {checkAndSave()}) {
                        NextButton(text: "Continue")
                    }
                    HStack {
                        Spacer()
                        Text("We do not sell your data to third parties.")
                            .opacity(0.6)
                        Spacer()
                    }
                        .font(.caption)
                    .padding(.bottom, 30)
                }
                .padding()
                .navigationTitle("Sign Up")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { self.showingAvatarGenerator = true; self.hapticsManager.simpleSuccess() }) {
                            Text("Edit avatar")
                        }
                    }
                }
            }
            .alert(isPresented: $usernameIsEmptyAlert) {
                Alert(title: Text("Select a username"), message: Text("Need ideas? Try Stockmaster, or Financial lover"), dismissButton: .default(Text("Got it!")))
            }
            .sheet(isPresented: $showingAvatarGenerator) {
                AvatarCreator()
                    .environmentObject(firstAvatar)
                    .environmentObject(hapticsManager)
            }
            .onAppear { self.hapticsManager.simpleSuccess() }
        }
    }
    
    private func checkAndSave() {
        if firstAvatar.username.isEmpty {
            self.usernameIsEmptyAlert = true
            hapticsManager.simpleError()
        } else {
            // Save settings to CLOUDKIT
            let userSettings = UserSettings(context: moc)
            userSettings.username = firstAvatar.username
            userSettings.body = firstAvatar.body
            userSettings.bodyColor = firstAvatar.bodyColor
            userSettings.eyes = firstAvatar.eyes
            userSettings.facialHair = firstAvatar.facialHair
            userSettings.mouth = firstAvatar.mouth
            userSettings.nose = firstAvatar.nose
            userSettings.skinTone = firstAvatar.skinTone
            userSettings.background = firstAvatar.background
            // Save AppIsAlreadyLaunched
            let defaults = UserDefaults.standard
            defaults.setValue(true, forKey: "IsAppAlreadyLaunchedOnce")
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
            .environmentObject(FirstAvatar())
    }
}

struct ProfileAvatar: View {
    @Binding var showingAvatarGenerator: Bool
    @EnvironmentObject var firstAvatar: FirstAvatar
    @EnvironmentObject var hapticsManager: HapticsManager
    
    var body: some View {
        HStack {
         Spacer()
            ZStack(alignment: .topTrailing) {
                Button(action: { self.showingAvatarGenerator = true; self.hapticsManager.simpleSuccess()}) {
                    Avatar()
                        .shadow(color: Color.gray.opacity(0.2), radius: 10)
                        .background(
                            Circle()
                                .foregroundColor(Color(firstAvatar.background))
                        )
                    
                }
            }
            
            Spacer()
        }
    }
}


struct UserNameTextfield: View {
    @EnvironmentObject var firstAvatar: FirstAvatar
    @Binding var username: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Choose your username")
                .font(.headline)
            
            TextField("Username", text: $username)
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
