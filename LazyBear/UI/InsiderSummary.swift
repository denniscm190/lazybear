//
//  InsiderSummary.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 5/3/21.
//

import SwiftUI
import SwiftUICharts

struct InsiderSummary: View {
    var symbol: String
    @State private var dataPoints = [DataPoint]()
    
    @FetchRequest(entity: UserSettings.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \UserSettings.changedAt, ascending: false)])
    var userSettings: FetchedResults<UserSettings>
    
    var body: some View {
        VStack(alignment: .leading) {
            if !dataPoints.isEmpty {
                HStack {
                    Image(systemName: "star.fill")
                        .renderingMode(.original)
                        .imageScale(.large)
                    
                    Text("Top insiders")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Spacer()
                }
            }
            
            HorizontalBarChartView(dataPoints: dataPoints)
        }
        .padding()
        .onAppear {
            // Empty array in case there is data already
            if !dataPoints.isEmpty {
                self.dataPoints = [DataPoint]()
            }
            
            generateChart()
        }
    }
    
    private func getUrl() -> String {
        let baseUrl = Bundle.main.infoDictionary?["IEX_URL"] as? String ?? "Empty url"
        let apiKey = Bundle.main.infoDictionary?["IEX_API"] as? String ?? "Empty key"
        let url = "\(baseUrl)/stock/\(symbol)/insider-roster?token=\(apiKey)"
        
        return url
    }
    
    private func generateChart() {
        request(url: getUrl(), model: [TopInsiderModel].self) { topInsiders in
            let theme = userSettings.first?.theme?.lowercased() ?? "default"
            // Loop over the response
            var insiderNumber = 0
            for insider in topInsiders {
                insiderNumber += 1
                if insiderNumber < 5 {
                    if let net = insider.position {
                        let index = topInsiders.firstIndex(of: insider)  // Get number (indice) of the item in the list
                        let rowNumber = index! % 5  // Get row color name
                        let color = Color("\(theme)Row\(rowNumber)")  // Define color
                        let label = LocalizedStringKey(insider.entityName.capitalized)  // Define label
                        let legend = Legend(color: color, label: label)  // Define legend SwiftUICharts
                        let dataPoint = DataPoint(value: Double(net), label: LocalizedStringKey(String(net)), legend: legend)
                        
                        dataPoints.append(dataPoint)
                    }
                }
            }
        }
    }
}

struct InsiderSummary_Previews: PreviewProvider {
    static var previews: some View {
        InsiderSummary(symbol: "aapl")
    }
}
