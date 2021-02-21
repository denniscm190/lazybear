//
//  CompanyView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI

struct CompanyView: View {
    @ObservedObject var hudManager: HUDManager
    @FetchRequest(entity: Company.entity(), sortDescriptors: []) var companies: FetchedResults<Company>
    @Environment(\.managedObjectContext) private var moc
    
    var name: String
    var symbol: String
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                //PriceView(symbol: symbol)
                HistoricalPriceView(symbol: symbol, chartHeight: geo.size.width / 2)
                NewsView(symbol: symbol)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Change view")
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                let symbols = companies.map { $0.symbol }
                if !symbols.contains(symbol) {
                    Button(action: { add() }) {
                        Image(systemName: "star")
                            .imageScale(.large)
                    }
                }
            }
        }
    }
    
    // Add to watchlist
    private func add() {
        let generator = UINotificationFeedbackGenerator()  // Haptic
        let company = Company(context: moc)
        company.symbol = symbol
        company.name = name
        do {
            try moc.save()
            hudManager.show(text: "Company saved", image: "checkmark.circle")
            generator.notificationOccurred(.success)
            print("Company saved.")
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CompanyView(hudManager: HUDManager(), name: "apple inc", symbol: "aapl")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
