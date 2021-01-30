//
//  LineView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/1/21.
//

import SwiftUI

struct LineView: View {
    var data: [(Double)]
    var title: String?
    var price: String?

    public init(data: [Double],
                title: String? = nil,
                price: String? = nil) {
        
        self.data = data
        self.title = title
        self.price = price
    }
    
    public var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading, spacing: 8) {
                Group{
                    if (self.title != nil){
                        Text(self.title!)
                            .font(.title)
                    }
                    if (self.price != nil){
                        Text(self.price!)
                            .font(.body)
                        .offset(x: 5, y: 0)
                    }
                }.offset(x: 0, y: 0)
                ZStack{
                    GeometryReader{ reader in
                        Line(data: self.data,
                             frame: .constant(CGRect(x: 0, y: 0, width: reader.frame(in: .local).width , height: reader.frame(in: .local).height))
                             
                        )
                            .offset(x: 0, y: 0)
                    }
                    .frame(width: geometry.frame(in: .local).size.width, height: 200)
                    .offset(x: 0, y: -100)

                }
                .frame(width: geometry.frame(in: .local).size.width, height: 200)
        
            }
        }
    }
}
