//
//  WelcomeView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.presentationMode) var welcomeView
    
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                VStack {
                    Image("default")
                        .resizable()
                        .frame(width: proxy.size.width*0.25, height: proxy.size.width*0.25)
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.3), radius: 10)
                        .padding(.vertical)
                    
                    Text("Lazybear")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    Text("Create watchlists, add companies, and follow the markets in real time.")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done", action: { dismissWelcome() })
                    }
                }
            }
        }
    }
    
    private func dismissWelcome() {
        UserDefaults.standard.set(true, forKey: "IsAppAlreadyLaunchedOnce")
        welcomeView.wrappedValue.dismiss()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
