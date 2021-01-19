//
//  StockStats.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 18/1/21.
//

import SwiftUI

struct StockStats: View {
    @State var dataMax: String
    @State var dataMin: String
    @State var width: CGFloat
    @State var height: CGFloat
    @State var title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Highest " + title)
                .titleModifier()
            
            DataObject(data: dataMax, colour: .green, type: title)
            Text("Lowest " + title)
                .titleModifier()
            
            DataObject(data: dataMin, colour: .red, type: title)
                

        }
        .frame(width: width, height: height)
    }
}

struct DataObject: View {
    @State var data: String
    @State var colour: Color
    @State var type: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(.white)
            .overlay(
                Text(unit() + " " + data)
                    .foregroundColor(colour)
                    .dataModifier()
            )
    }
    
    func unit() -> String {
        if type == "price" {
            return "$ "
        }
        else {
            return ""
        }
    }
}
extension Text {
    func dataModifier() -> some View {
        self
            .font(.title3)
            .fontWeight(.bold)
    }
}

extension Text {
    func titleModifier() -> some View {
        self
            .font(.title2)
            .fontWeight(.bold)
    }
}

struct StockStats_Previews: PreviewProvider {
    static var previews: some View {
        StockStats(dataMax: "500.00", dataMin: "200.00", width: 360, height: 240, title: "price")
    }
}
