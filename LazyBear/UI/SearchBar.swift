//
//  SearchBar.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 19/2/21.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchedText: String
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            TextField("Search ...", text: $searchedText)
                .padding(.horizontal, 45)
                .padding(.vertical, 10)
                .background(Color(.systemGray6).cornerRadius(10))
                .overlay(overlay, alignment: .leading)
            
            
            if isEditing {
                cancel
                    .transition(.move(edge: .trailing))
            }
        }
        .padding(.horizontal)
        .onTapGesture {
            withAnimation {
                self.isEditing = true
            }
        }
    }
    
    var overlay: some View {
        Image(systemName: "magnifyingglass")
            .opacity(0.2)
            .padding(.leading)
    }
    
    var cancel: some View {
        Button(action: {
            withAnimation {
            self.searchedText = ""
            self.isEditing = false
            // Force hide keyboard
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }) {
            Text("Cancel")
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SearchBar(searchedText: .constant(""))
            Spacer()
        }
    }
}
