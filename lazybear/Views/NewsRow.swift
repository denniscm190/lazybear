//
//  NewsRow.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 4/2/21.
//

import SwiftUI

struct NewsRow: View {
    @State var new: NewsModel
    @State private var showDetails = false
    
    var body: some View {
        Button(action: { self.showDetails.toggle() }) {
            VStack(alignment: .leading) {
                Text(new.source ?? "-")
                    .font(.caption2)
                
                Text(new.headline ?? "-")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(4)
                
                Text(new.summary ?? "-")
                    .lineLimit(3)
                    .font(.caption)
                    .padding(.top, 3)
                
                let (hours, minutes) = epochToHours()
                Text("\(hours) hours and \(minutes) minutes ago")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.top, 3)
                
                Divider()
            }
            .padding([.leading, .trailing])
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showDetails) {
            NewsDetail(new: self.new)
        }
    }
    
    private func epochToHours() -> (String, String) {
        let now = Date() // Current date
        let articlePublished = Date(timeIntervalSince1970: TimeInterval(new.datetime ?? 0)/1000)
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: articlePublished, to: now)
        
        return (String(components.hour ?? 0), String(components.minute ?? 0))
    }
}

struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(new: NewsModel(datetime: 248375623, headline: "Leak says Apple’s first mixed-reality headset will cost $3,000", source: "BGR", url: "", summary: "A new report lists the purported price and release date of Apple’s upcoming high-end mixed-reality (MR) glasses. The headset will supposedly retail for around $3,000 in 2022. The device will reportedly use cameras to track the wearer's hands, while internal sensors track eye movements. The headset is said to feature two 8K displays that will follow the eyes' movement, displaying the images that are in focus at high resolution, with objects in peripheral vision being shown at a lower resolution. Apple has been rumored more than once to be developing its own smart headgear that would work in tandem with other devices, like the iPhone or a Mac. The so-called Apple Glasses project has been the subject.", image: ""))
    }
}
