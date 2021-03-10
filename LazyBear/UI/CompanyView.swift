//
//  CompanyView.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI

enum ViewType {
    case stock, insiders
}

struct CompanyView: View {
    var name: String
    var symbol: String
    
    @ObservedObject var hudManager: HudManager
    @FetchRequest(entity: Company.entity(), sortDescriptors: []) var companies: FetchedResults<Company>
    @Environment(\.managedObjectContext) private var moc

    @State var viewState = ViewType.stock
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                if viewState == .stock {
                        PriceView(symbol: symbol)
                        ChartView(symbol: symbol, chartHeight: geo.size.width / 2)
                        NewsView(symbol: symbol)
                        
                } else if viewState == .insiders {
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
            CompanyView(name: "apple inc", symbol: "aapl", hudManager: HudManager())
                .navigationTitle("APPL")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
