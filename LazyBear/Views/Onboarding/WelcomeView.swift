//
//  WelcomeView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/3/21.
//

import SwiftUI

struct WelcomeView: View {
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: []) var userSettings: FetchedResults<UserSettings>
    @ObservedObject var environmentSignUp = EnvironmentSignUp()
    @State private var showingNextView = false
    @State private var showingProgressView = false
    
    var body: some View {
        if showingNextView {
            if userSettings.isEmpty {
                SignUpView()
                    .environmentObject(environmentSignUp)
            } else {
                ContentView()
            }
            
        } else {
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    Spacer()
                    Image("default")
                        .resizable()
                        .frame(width: geo.size.width * 0.25, height: geo.size.width * 0.25)
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.2), radius: 10)
                    
                    Group {
                        Text("Welcome to")
                            .fontWeight(.black)
                        Text("Lazybear")
                            .fontWeight(.black)
                            .foregroundColor(Color("default"))
                    }
                    .font(.largeTitle)
                    
                            
                    Text("Easily follow your stocks and the markets in real-time.")
                        .padding(.top, 5)
                    
                    HStack {
                        if self.showingProgressView {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }
                    .padding()
                    .frame(height: 30)
                    
                    Spacer()
                }
                .padding(geo.size.width * 0.15)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.showingNextView = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.showingProgressView = true
                    }
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
