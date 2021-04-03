//
//  HelpSheet.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 3/4/21.
//

import SwiftUI

struct HelpSheet: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var hudManager: HudManager
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: { hudManager.showSearchHelper = false }) {
                    Image(systemName: "multiply.circle")
                        .imageScale(.large)
                }
            }
            
            Group {
                Text("How to search a company?")
                    .font(.headline)
                
                Text("Just tap on the search bar and type the company name or stock symbol. You'll see rows like this: ")
                    .multilineTextAlignment(.leading)
                
                TutorialRow()
                
                let explanation = "The left side shows you the stock symbol, and the company name. The right side shows you the quote currency, and in what region the stock is trading."
                
                Text(explanation)
                    .multilineTextAlignment(.leading)
            }
            .padding(.bottom)

        }
        .padding()
        .background(
            ZStack {
                BlurBackground(style: .systemMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(colorScheme == .dark ? Color(.secondarySystemBackground): .white)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0.0, y: 5)
            }
        )
    }
}

struct HelpSheet_Previews: PreviewProvider {
    static var previews: some View {
        HelpSheet()
            .environmentObject(HudManager())
    }
}


struct TutorialRow: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(height: 55)
            .foregroundColor(colorScheme == .dark ? Color(.tertiarySystemBackground): Color(.secondarySystemBackground))
            .overlay(
                HStack {
                    VStack {
                        Text("AAPL")
                            .fontWeight(.semibold)
                        
                        Text("Apple Inc")
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("USD")
                            .fontWeight(.semibold)
                        
                        Text("US")
                    }
                }
                .padding()
            )
    }
}
