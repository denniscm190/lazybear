//
//  CompanyView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI

struct CompanyView: View {
    var name: String
    var symbol: String
    
    @EnvironmentObject var hudManager: HudManager
    @EnvironmentObject var companyType: CompanyType
    @FetchRequest(entity: Company.entity(), sortDescriptors: []) var companies: FetchedResults<Company>
    @Environment(\.managedObjectContext) private var moc
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                if companyType.view == .stock {
                        PriceView(symbol: symbol)
                        ChartView(symbol: symbol, chartHeight: geo.size.width / 2)
                        NewsView(symbol: symbol)
                        
                } else if companyType.view == .insiders {
                    InsiderSummary(symbol: symbol)
                    InsiderTransactions(symbol: symbol)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Button(action: { self.hudManager.showAction.toggle() }) {
                    Text("Test")
                }
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
            hudManager.selectHud(type: .notification)
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
            CompanyView(name: "apple inc", symbol: "aapl")
                .navigationTitle("APPL")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
