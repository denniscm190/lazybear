//
//  DetailNew.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 3/3/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailNew: View {
    var new: NewsModel
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text(new.headline ?? "")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .padding(.top)
                
                    VStack(alignment: .leading) {
                        WebImage(url: URL(string: new.image ?? ""))
                            .resizable()
                            .indicator(.activity)
                            .scaledToFit()
                        
                        Text(new.summary ?? "")
                            .padding(.horizontal)
                        
                        Link("Read the full story", destination: URL(string: new.url ?? "")!)
                            .padding(.horizontal)
                            .padding(.top)
                    }
                }
            }
            .navigationTitle(new.source ?? "-")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DetailNew_Previews: PreviewProvider {
    static var previews: some View {
        DetailNew(new: NewsModel(datetime: 1613838000000, headline: "As Facebook, Microsoft, Apple, Uber, Amazon, and others play larger roles in OpenStreetMap, hobbyists fear private sector will overshadow their work (Corey Dickinson/Bloomberg)", source: "Techmeme", url: "https://cloud.iexapis.com/v1/news/article/d760b0bc-42f0-4ed0-a721-a7691eeaa132", summary: "Corey Dickinson / Bloomberg : As Facebook, Microsoft, Apple, Uber, Amazon, and others play larger roles in OpenStreetMap, hobbyists fear private sector will overshadow their work — What do Lyft, Facebook, the International Red Cross, the U.N., the government of Nepal and Pokémon Go have in common?", image: "https://cloud.iexapis.com/v1/news/image/d760b0bc-42f0-4ed0-a721-a7691eeaa132"))
    }
}
