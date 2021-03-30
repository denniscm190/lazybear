//
//  TopStockItem.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 28/3/21.
//

import SwiftUI

struct TopStockItem: View {
    
    var body: some View {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(.secondarySystemBackground))
                .aspectRatio(0.8, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    VStack(alignment: .leading) {
                        Group {
                            Text("Symbol".uppercased())
                                .fontWeight(.semibold)
                                .padding(.top)
                            
                            Text("Company name".capitalized)
                                .fontWeight(.semibold)
                                .opacity(0.6)
                            
                            Text("$120.20")
                                .foregroundColor(.green)
                                .fontWeight(.semibold)
                                .padding(.top)
                            
                            Text("+\(1.22, specifier: "%.2f")%")
                                .foregroundColor(.green)
                                .fontWeight(.semibold)
                                
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                         
                        
                        LineView()
                            .foregroundColor(.green)
                            .padding(.vertical)
                            .clipped()
                            
                            
                    }
                )
    }
}

struct TopStockItem_Previews: PreviewProvider {
    static var previews: some View {
        TopStockItem()

    }
}
