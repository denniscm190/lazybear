//
//  InsiderList.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/6/21.
//

import SwiftUI

struct InsiderList: View {
    var insiderSummary: [InsiderRosterModel]
    @State private var showFullList = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Top 10 insiders")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                Button("See all", action: { showFullList = true })
            }
        
            // Get total shares owned by the top 10 insiders
            let totalPositions =  insiderSummary.map { $0.position ?? 0 }.reduce(0, +)
            VStack(alignment: .leading, spacing: 20) {
                ForEach(insiderSummary.prefix(3), id: \.self) { insider in
                    
                    // Compute percentage of ownership for each insider
                    let percentage = Double(insider.position ?? 0) / Double(totalPositions)
                    
                    InsiderRow(percentageOfWidth: CGFloat(percentage), insiderRoster: insider)
                }
            }
        }
        .sheet(isPresented: $showFullList) {
            InsiderFullList(insiderSummary: insiderSummary)
        }
    }
}

struct InsiderList_Previews: PreviewProvider {
    static var previews: some View {
        InsiderList(insiderSummary:
                    [InsiderRosterModel(entityName: "Dennis Concepcion", position: 1234, reportDate: 1234567)]
        )
    }
}

struct InsiderFullList: View {
    var insiderSummary: [InsiderRosterModel]
    @Environment(\.presentationMode) private var presentationInsiderFullList
    
    var body: some View {
        NavigationView {
            ScrollView {
                // Get total shares owned by the top 10 insiders
                let totalPositions =  insiderSummary.map { $0.position ?? 0 }.reduce(0, +)
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(insiderSummary, id: \.self) { insider in
                        
                        // Compute percentage of ownership for each insider
                        let percentage = Double(insider.position ?? 0) / Double(totalPositions)
                        
                        InsiderRow(percentageOfWidth: CGFloat(percentage), insiderRoster: insider)
                    }
                }
                .padding()
            }
            .navigationTitle("Top 10 insiders")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { presentationInsiderFullList.wrappedValue.dismiss() }) {
                        Image(systemName: "multiply")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
}
