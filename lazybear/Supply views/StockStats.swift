//
//  StockStats.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 18/1/21.
//

import SwiftUI

struct StockStats: View {
    @State var dataMax: Double
    @State var dataMin: Double
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
    @State var data: Double
    @State var colour: Color
    @State var type: String
    
    var body: some View {
        let units = unit()
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(.white)
            .overlay(
                Text("\(units.0) \(data, specifier: "%.2f") \(units.1)")
                    .foregroundColor(colour)
                    .dataModifier()
            )
    }
    
    func unit() -> (String, String) {
        var dollar = ""
        var pct = ""
        if type == "price" {
            dollar = "$"
        }
        else if type == "daily change" {
            pct = "%"
        }
        
        return (dollar, pct)
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
        StockStats(dataMax: 500.00, dataMin: 200.00, width: 360, height: 240, title: "price")
    }
}
