//
//  WhatsNew.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 31/12/20.
//

import SwiftUI
import SwiftUICharts

struct WhatsNew: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                let intro = "This new version comes with lots of changes and many cool stuff. I've been working hard to improve the backend efficiency, deploy a new API and other boring stuff that you probably are not interested in. So let's talk about the cool stuff."
                Text(intro)
                    
                let title1 = "New design"
                let text1 = "As you can see, there is a completely new design, more clean, colourful, and simple. Now you can check the date for the company you want in three clicks. Less is more."
                Text(title1 + " 😎")
                    .title()
                    
                Text(text1)
                
                let title2 = "Charts! A bunch!"
                let text2 = "Look how cool they are"
                Text(title2)
                    .title()
                
                Text(text2 + " 😁")
                HStack {
                    Spacer()
                    LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Some cool title", form: ChartForm.large, rateValue: 14)
                    Spacer()
                }
                
                let title3 = "Stock prices"
                let text3 = "Finally I found a not-so-expensive method to show stock prices. In this version you can see the latest stock price from the previous day, but I promise you in future versions I am going to add real-time stock prices."
                Text(title3)
                    .title()
                
                Text(text3)
            }
            .padding()
        }
    }
}
extension Text {
    func title() -> some View {
        self
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .fontWeight(.semibold)
    }
}

struct WhatsNew_Previews: PreviewProvider {
    static var previews: some View {
        WhatsNew()
    }
}
