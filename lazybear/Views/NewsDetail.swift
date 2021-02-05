//
//  NewsDetail.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 5/2/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsDetail: View {
    @State var new: NewsModel
    @Environment(\.presentationMode) var detailPresentation
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button(action: { self.detailPresentation.wrappedValue.dismiss() }) {
                    Image(systemName: "multiply.circle.fill")
                }
            }
        
            Text(new.source ?? "-")
                .font(.caption2)
            
            Text(new.headline ?? "-")
                .font(.title)
                .fontWeight(.semibold)
            
            ScrollView {
                VStack(alignment: .leading) {
                    WebImage(url: URL(string: new.image ?? ""))
                        .resizable()
                        .indicator(.activity)
                        .scaledToFit()
                    
                    Divider()
                    Text(new.summary ?? "-")
                    Link("Read the full article", destination: URL(string: new.url ?? "")!)
                        .padding(.top)
                }

            }
        }
        .padding()
    }
}

struct NewsDetail_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetail(new: NewsModel(datetime: 248375623, headline: "Leak says Apple’s first mixed-reality headset will cost $3,000", source: "BGR", url: "", summary: "A new report lists the purported price and release date of Apple’s upcoming high-end mixed-reality (MR) glasses. The headset will supposedly retail for around $3,000 in 2022. The device will reportedly use cameras to track the wearer's hands, while internal sensors track eye movements. The headset is said to feature two 8K displays that will follow the eyes' movement, displaying the images that are in focus at high resolution, with objects in peripheral vision being shown at a lower resolution. Apple has been rumored more than once to be developing its own smart headgear that would work in tandem with other devices, like the iPhone or a Mac. The so-called Apple Glasses project has been the subject.", image: ""))
    }
}
