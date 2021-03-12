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
    
    var body: some View {
        VStack {
            VStack {
                Group {
                    Button(action: { changeViewTo(.stock) }) {
                        Image(systemName: "chart.bar")
                        Text("Stock & news")
                        Spacer()
                    }
                    Divider()
                        .offset(x: 45)
                    
                    Button(action: { changeViewTo(.insiders) }) {
                        Image(systemName: "chart.pie")
                        Text("Insider transactions")
                        Spacer()
                    }
                }
                .modifier(Title())
            }
            .padding()
            .background(
                Color(.white)
                    .cornerRadius(20)
            )
            
            Button(action: { self.hudManager.showAction = false }) {
                Spacer()
                Text("Cancel")
                Spacer()
            }
            .modifier(Title())
            .padding(.vertical)
            .background(
                Color(.white)
                    .cornerRadius(20)
            )
        }
        .frame(maxWidth: 600)
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
