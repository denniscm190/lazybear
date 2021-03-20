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
    @State private var scale: CGFloat = 1
    @EnvironmentObject var hudManager: HudManager
    @EnvironmentObject var companyOption: CompanyOption
    @EnvironmentObject var hapticsManager: HapticsManager
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Company.entity(), sortDescriptors: []) var companies: FetchedResults<Company>
    
    var body: some View {
        ScrollView {
            if companyOption.view == .stock {
                PriceView(symbol: symbol, showVertical: false)
                ChartView(symbol: symbol)
                KeyStatsView(symbol: symbol)
                NewsView(symbol: symbol)
                    
            } else if companyOption.view == .insiders {
                InsiderSummary(symbol: symbol)
                InsiderTransactions(symbol: symbol)
            }
        }
        .onAppear { companyOption.view = .stock }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Button(action: { self.hudManager.showAction.toggle(); hapticsManager.complexSuccess()}) {
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
                    Button(action: { addCompany() }) {
                        Image(systemName: "star")
                    }
                    .scaleEffect(scale)
                    .animation(.easeIn)
                    
                } else {
                    Button(action: { removeCompany() }) {
                        Image(systemName: "star.fill")
                    }
                }
            }
        }
    }
    
    // Add to watchlist
    private func addCompany() {
        let company = Company(context: moc)
        company.symbol = symbol
        company.name = name
        do {
            try moc.save()
            hudManager.selectHud(type: .notification)
            hapticsManager.simpleSuccess()
            print("Company saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func removeCompany() {
        let symbols = companies.map { $0.symbol }
        let index = symbols.firstIndex(of: symbol)
        let company = companies[index!]
        moc.delete(company)
        do {
            try moc.save()
            print("Company deleted")
        } catch {
            // Error
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
