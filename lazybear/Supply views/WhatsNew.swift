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
        GeometryReader { geo in
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Group {
                        let intro = "This new version comes with lots of changes and many cool stuff. I've been working hard to improve the backend efficiency, deploy a new API and other boring stuff that you probably are not interested in. So let's talk about the cool stuff."
                        Text(intro)
                    }
                    
                    Group {
                        let title1 = "New design"
                        let text1 = "As you can see, there is a completely new design, more clean, colourful, and simple. Less is more."
                        Text(title1 + " 😎")
                            .title()
                            
                        Text(text1)
                    }
                    
                    Group {
                        let title2 = "Charts! A bunch!"
                        let text2 = "Look how cool they are"
                        Text(title2)
                            .title()
                        
                        Text(text2 + " 😁")
                    }
                    
                    Group {
                        HStack {
                            Spacer()
                            let width = geo.size.height*0.4
                            LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Some cool title", form: CGSize(width: width, height: width/2), rateValue: 14)
                            Spacer()
                        }
                    }
                    
                    Group {
                        let title3 = "Stock prices"
                        let text3 = "Finally I found a not-so-expensive method to show stock prices. In this version you can see the latest stock price from the previous day, but I promise you in future versions I am going to add real-time stock prices."
                        Text(title3)
                            .title()
                        
                        Text(text3)
                    }
                    
                    Group {
                        let title4 = "Watchlist 👀"
                        let text4 = "Now, you can save your favourite companies to have a quick access whenever you want."
                        Text(title4)
                            .title()
                        
                        Text(text4)
                        
                        Text("Favourites")
                            .font(.headline)
                        
                        ExampleFavourite(companyName: "Apple Inc")
                        ExampleFavourite(companyName: "Netflix")
                        ExampleFavourite(companyName: "Goldman Sachs")
                    }
                }
                .padding()
            }
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

struct ExampleFavourite: View {
    @State var companyName: String
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .renderingMode(.original)
            Text(companyName)
        }
    }
}

struct WhatsNew_Previews: PreviewProvider {
    static var previews: some View {
        WhatsNew()
    }
}
