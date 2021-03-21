//
//  WelcomeView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/3/21.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showingOnboardView = false
    @State private var showProgressView = false
    
    var body: some View {
        if showingOnboardView {
            OnboardView()
        } else {
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    Spacer()
                    Image("default")
                        .resizable()
                        .frame(width: geo.size.width * 0.2, height: geo.size.width * 0.2)
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.2), radius: 10)
                    
                    Group {
                        Text("Welcome to")
                        Text("Lazybear")
                            .foregroundColor(.blue)
                            .offset(y: -15)
                            .padding(.bottom, -15)
                    }
                    .font((.system(size: 50, weight: .black)))
                            
                    Text("Easily follow your stocks and the markets in real-time.")
                    
                    HStack {
                        if self.showProgressView {
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
                        self.showingOnboardView = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.showProgressView = true
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
