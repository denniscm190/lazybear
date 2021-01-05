//
//  Settings.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/12/20.
//

import SwiftUI

struct About: View {
    @Environment(\.presentationMode) var aboutPresentation
    
    var body: some View {
        NavigationView {
            VStack(alignment:.leading) {
                AppInfo()
                
                List {
                    NavigationLink(destination: WhatsNew()
                                    .navigationBarTitle("What's new")
                    ) {
                        AboutButton(image: "sparkles", name: "What's new")
                    }
                    Button(action: openUrl(url: "https://apps.apple.com/es/app/lazybear-insider-trading/id1534612943?l=en")) {
                        AboutButton(image: "checkmark.circle.fill", name: "Rate Lazybear")
                    }
                    NavigationLink(destination: TipJar()) {
                        AboutButton(image: "gift.fill", name: "Tip jar")
                    }
                    Button(action: openUrl(url: "https://twitter.com/LazybearApp")) {
                        AboutButton(image: "at.circle.fill", name: "@Lazybear")
                    }
                    Button(action: openUrl(url: "https://twitter.com/dennisconcep")) {
                        AboutButton(image: "at.circle.fill", name: "@DennisConcep")
                    }
                    Button(action: openUrl(url: "https://lazybear.app")) {
                        AboutButton(image: "link.circle.fill", name: "Website")
                    }
                    Button(action: openUrl(url: "https://github.com/denniscm190/lazybear-iOS")) {
                        AboutButton(image: "star.fill", name: "Github")
                    }
                    Button(action: {   }) {
                        AboutButton(image: "filemenu.and.selection", name: "Terms & Privacy policy")
                    }
                    Button(action: {   }) {
                        AboutButton(image: "envelope.circle.fill", name: "Contact")
                    }
                }
            }
            .padding()
            .navigationTitle("About")
            .navigationBarItems(leading:
                Button(action: {self.aboutPresentation.wrappedValue.dismiss()}) {
                    Image(systemName: "multiply")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
            )
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func openUrl(url: String) -> () -> () {
        return {
            if let url = URL(string: url) {
                UIApplication.shared.open(url)
            }
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            About()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
