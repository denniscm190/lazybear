//
//  WhatsNewView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 21/3/21.
//

import SwiftUI

extension Animation {
    static func ripple(index: Int) -> Animation {
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
            .delay(0.03 * Double(index))
    }
}

class WhatsNewRowItems {
    var icons = ["heart.fill", "chart.bar.fill", "paintbrush.fill"]
    var iconColors: [Color] = [.red, .blue, .green]
    var headlines = ["Your stocks at a glance", "Interactive charts", "New design"]
    var bodyTexts = ["Easily create watchlists with your favourite companies.", "Long press, drag, tap and have fun with the charts.", "Modern, clean and neat without losing simplicty."]
}
struct WhatsNewView: View {
    let whatsNewRowItems = WhatsNewRowItems()
    @State private var showingButton = false
    @State private var showingRows = false
    @State var showingContentView = false
    
    var body: some View {
        if !showingContentView {
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    Text("What's new")
                        .font(.system(size: 50, weight: .black))
                        .padding(.bottom)
                        .opacity(showingRows ? 1: 0)
                        .animation(.easeInOut)
                    
                    ForEach((0..<3), id: \.self) { index in
                        if showingRows {
                            WhatsNewRow(icon: whatsNewRowItems.icons[index], iconColor: whatsNewRowItems.iconColors[index], headline: whatsNewRowItems.headlines[index], bodyText: whatsNewRowItems.bodyTexts[index], position: index+1)
                                .transition(.slide)
                                .animation(.ripple(index: index))
                        }
                    }
                    Spacer()
                    WhatsNewButton(showContentView: $showingContentView)
                        .offset(y: showingButton ? 0 : 200)
                        .animation(.easeInOut)
                    
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.showingButton = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.showingRows = true
                    }
                }
                .padding(geo.size.width * 0.15)
            }
        } else {
            ContentView()
        }
    }
}

struct WhatsNewView_Previews: PreviewProvider {
    static var previews: some View {
        WhatsNewView()
    }
}

struct WhatsNewRow: View {
    var icon: String
    var iconColor: Color
    var headline: String
    var bodyText: String
    var position: Int
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: icon)
                .foregroundColor(iconColor)
                .frame(width: 40)
                .font(.system(size: 35))
                .padding(.trailing)
            
            VStack(alignment: .leading) {
                Text(headline)
                    .font(.headline)
                
                Text(bodyText)
            }
        }
        .padding(.bottom)
    }
}

struct WhatsNewButton: View {
    @Binding var showContentView: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: { self.showContentView = true }) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.blue)
                    .frame(height: 50)
                    .overlay(
                    Text("Continue")
                        .foregroundColor(.white)
                    )
            }
            
            Spacer()
        }
    }
    
//    func writeUserDefaults() {
//        let defaults = UserDefaults.standard
//        defaults.setValue(true, forKey: "IsAppAlreadyLaunchedOnce")
//    }
}
