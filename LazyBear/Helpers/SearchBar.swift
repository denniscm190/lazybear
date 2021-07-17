//
//  SearchBar.swift
//  lazybear
//
//  Created by Dennis Concepción Martín on 17/07/2021.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
               .foregroundColor(Color(.secondarySystemBackground))
            
             HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search ..", text: $searchText) { startedEditing in
                    if startedEditing {
                        withAnimation {
                            searching = true
                        }
                    }
                }
                onCommit: {
                     withAnimation {
                         searching = false
                     }
                 }
             }
             .padding(.leading, 13)
            
         }
        .frame(height: 40)
        .cornerRadius(13)
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant(""), searching: .constant(false))
    }
}
