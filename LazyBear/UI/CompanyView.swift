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
    @EnvironmentObject var hudManager: HudManager
    @EnvironmentObject var companyOption: CompanyOption
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Company.entity(), sortDescriptors: [])
    var companies: FetchedResults<Company>
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                if companyOption.view == .stock {
                    PriceView(symbol: symbol, showVertical: false)
                        ChartView(symbol: symbol, chartHeight: geo.size.width / 2)
                        NewsView(symbol: symbol)
                        
                } else if companyOption.view == .insiders {
                    InsiderSummary(symbol: symbol)
                    InsiderTransactions(symbol: symbol)
                }
            }
            .onAppear { companyOption.view = .stock }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Button(action: { self.hudManager.showAction.toggle() }) {
                    HStack {
                        if companyOption.view == .stock {
                            Text("Stock")
                        } else if companyOption.view == .insiders {
                            Text("Insiders")
                        }
                        Image(systemName: "chevron.down")
                    }
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
                .environmentObject(HudManager())
                .environmentObject(CompanyOption())
                .navigationTitle("APPL")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
