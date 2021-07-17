//
//  CompanyView.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//

import SwiftUI
import Alamofire
import MapKit

struct CompanyView: View {
    var symbol: String
    @State private var companyInfo = CompanyInfoModel()
    @State private var companyQuote = CompanyQuoteModel()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [], animation: .default) private var companies: FetchedResults<Company>
    
    var body: some View {
        ScrollView {
            VStack {
                MapSection(state: companyInfo.state ?? "New York")
                
                VStack(alignment: .leading) {
                    Text(companyInfo.symbol ?? "")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    
                    HStack {
                        Text(companyInfo.companyName ?? "")
                        Spacer()
                        Text(companyInfo.state ?? "")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    Divider()
                    StockSection(companyQuote: companyQuote)
                        .padding(.bottom)
                    
                    AboutSection(companyInfo: companyInfo)
                    
                    Spacer()
                }
                .padding()
            }
        }
        .ignoresSafeArea(edges: .top)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                let watchlistSymbols = companies.map { $0.symbol }
                    if watchlistSymbols.contains(symbol) {
                        Button(action: deleteCompanyFromWatchlist) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 25))
                        }
                        
                    } else {
                        Button(action: addCompanyToWatchlist) {
                            Image(systemName: "star")
                                .font(.system(size: 25))
                        }
                    }
            }
        }
        .onAppear(perform: requestApi)
    }
    
    // MARK: - REQUEST API
    private func requestApi() {
        // Request company information
        var url = "https://cloud.iexapis.com/stable/stock/\(symbol)/company?token=pk_58fd944e924e4a70acf8635bc335cec4"
        
        AF.request(url).responseDecodable(of: CompanyInfoModel.self) { response in
            if let value = response.value {
                self.companyInfo = value
            } else {
                // Handle error
            }
        }
        
        // Request quote
        url = "https://cloud.iexapis.com/stable/stock/\(symbol)/quote?token=pk_58fd944e924e4a70acf8635bc335cec4"
        AF.request(url).responseDecodable(of: CompanyQuoteModel.self) { response in
            if let value = response.value {
                self.companyQuote = value
            }
            else {
                // Handle error
            }
        }
    }
    
    // MARK: - ADD CORE DATA
    private func addCompanyToWatchlist() {
        withAnimation {
            let company = Company(context: viewContext)
            company.symbol = symbol
            company.companyName = companyQuote.companyName!

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - DELETE CORE DATA
    private func deleteCompanyFromWatchlist() {
        withAnimation {
            let company = companies.first(where: { $0.symbol == symbol })
            viewContext.delete(company!)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct CompanyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CompanyView(symbol: "AAPL")
        }
    }
}
