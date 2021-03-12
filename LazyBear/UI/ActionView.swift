//
//  ActionView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 8/3/21.
//

import SwiftUI

struct ActionView: View {
    @EnvironmentObject var companyType: CompanyType
    @EnvironmentObject var hudManager: HudManager
    @Environment(\.colorScheme) var colorScheme  // Detect dark mode
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Group {
                    Button(action: { changeViewTo(.stock) }) {
                        Image(systemName: "chart.bar")
                            .frame(width: 50)
                        
                        Text("Stock & news")
                        Spacer()
                    }
                    .padding([.leading, .top, .trailing])
                    
                    Divider()
                        .offset(x: 75)
                    
                    Button(action: { changeViewTo(.insiders) }) {
                        Image(systemName: "chart.pie")
                            .frame(width: 50)
                        
                        Text("Insider transactions")
                        Spacer()
                    }
                    .padding([.leading, .bottom, .trailing])
                }
                .modifier(Title())
            }
            .background(
                colorScheme == .dark ? Color(red: 0.15, green: 0.17, blue: 0.18): Color(.white)
            )
            .cornerRadius(20)
            
            Button(action: { self.hudManager.showAction = false }) {
                Spacer()
                Text("Cancel")
                Spacer()
            }
            .modifier(Title())
            .padding()
            .background(
                colorScheme == .dark ? Color(red: 0.15, green: 0.17, blue: 0.18): Color(.white)
            )
            .cornerRadius(20)
        }
    }
        
    private func changeViewTo(_ view: ViewType ) {
        // Show view after one second.
        // Give time to dismiss the Action View
        self.hudManager.showAction = false
        
        if view == .stock {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.companyType.view = .stock
                
            }
        } else if view == .insiders {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.companyType.view = .insiders
            }
        }
    }
}


struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        ActionView()
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .imageScale(.large)
            .frame(maxWidth: .infinity)
    }
}

