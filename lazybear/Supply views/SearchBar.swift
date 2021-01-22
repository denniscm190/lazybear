//
//  SearchBar.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 27/12/20.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchedText: String
    @State var searchBarIsEditing = false
    @Binding var showingSearch: Bool  // Show search view in ContentView
    
    var body: some View {
        HStack {
            TextField("Search ...", text: $searchedText)
                .padding(10)
                .padding(.horizontal, 45)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                            .foregroundColor(Color("placeholder"))
                 
                        if searchBarIsEditing {
                            Button(action: {
                                self.searchedText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(Color("placeholder"))
                                    .padding(.trailing)
                            }
                        }
                    }
                )
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .onTapGesture {
                    self.searchBarIsEditing = true
                    self.showingSearch = true  // Content View
                    
                    
                }
 
            if searchBarIsEditing {
                Button(action: {
                    self.searchedText = ""
                    self.searchBarIsEditing = false
                    self.showingSearch = false  // Content View
                    
                    // Force hide keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
 
                }) {
                    Text("Cancel")
                }
            }
        }
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchedText: .constant(""), showingSearch: .constant(true))
    }
}
