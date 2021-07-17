//
//  Search.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//

import SwiftUI
import Alamofire

struct Search: View {
    @State var searchCompany = ""
    @State var searching = false
    @State private var companies: [SearchModel] = []
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchCompany, searching: $searching)
                .onChange(of: searchCompany, perform: { _ in
                    requestApi()
                })
            Spacer()
            if companies.isEmpty {
                
            } else {
                List(companies, id: \.self) { company in
                    NavigationLink(destination: CompanyView(symbol: company.symbol!)) {
                        SearchRow(company: company)
                    }
                }
                .id(UUID())
                .listStyle(InsetListStyle())
                .gesture(DragGesture()
                    .onChanged({ _ in
                         UIApplication.shared.dismissKeyboard()
                     })
                )
            }
        }
        .navigationTitle("Search")
        .toolbar {
             if searching {
                Button("Cancel") { searchCompany = ""; companies = []
                     withAnimation {
                        searching = false
                        UIApplication.shared.dismissKeyboard()
                     }
                 }
             }
        }
            .if(UIDevice.current.userInterfaceIdiom == .phone) { content in
                NavigationView { content }
            }
    }
    
    private func requestApi() {
        let url = "https://cloud.iexapis.com/stable/search/\(searchCompany)?token=pk_58fd944e924e4a70acf8635bc335cec4"
        AF.request(url).responseDecodable(of: [SearchModel].self) { response in
            if let value = response.value {
                self.companies = value
            } else {
                // Handle error
            }
        }
    }
}
extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
