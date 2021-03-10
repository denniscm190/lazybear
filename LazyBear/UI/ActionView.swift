//
//  ActionView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 8/3/21.
//

import SwiftUI

struct ActionView: View {
    
    var body: some View {
        VStack {
            VStack {
                Group {
                    Button(action: {  }) {
                        Image(systemName: "chart.bar")
                        Text("Stock & news")
                        Spacer()
                    }
                    Divider()
                        .offset(x: 45)
                    
                    Button(action: {  }) {
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
            
            Button(action: {  }) {
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
