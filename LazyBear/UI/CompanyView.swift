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
    
    @ObservedObject var hudManager: HUDManager
    @FetchRequest(entity: Company.entity(), sortDescriptors: []) var companies: FetchedResults<Company>
    @Environment(\.managedObjectContext) private var moc
    
    @State private var showingAction = false
    @State var viewState = ViewType.stock
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                if viewState == .stock {
                        PriceView(symbol: symbol)
                        ChartView(symbol: symbol, chartHeight: geo.size.width / 2)
                        NewsView(symbol: symbol)
                        
                } else if viewState == .insiders {
                    InsiderSum(symbol: symbol)
                    InsiderTrans(symbol: symbol)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Button(action: { self.showingAction = true }) {
                    if viewState == .stock {
                        Text("Stock")
                    } else if viewState == .insiders {
                        Text("Insiders")
                    }
                    Image(systemName: "chevron.down")
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
        .actionSheet(isPresented: $showingAction) {
            ActionSheet(title: Text("Select an option"), buttons: [
                .default(Text("Stock & news")) { self.viewState = ViewType.stock },
                .default(Text("Insiders")) { self.viewState = ViewType.insiders },
                .cancel()
                ])
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
            CompanyView(name: "apple inc", symbol: "aapl", hudManager: HUDManager())
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
