//
//  Selection.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 30/12/20.
//

import SwiftUI

struct Selection: View {
    @Binding var showingInsiders: Bool
    @Binding var showingStocks: Bool
    
    var body: some View {
        // Buttons
        HStack {
            Group {
                // Insiders
                Button(action: {toggle(type: "insider")}) {
                    if showingInsiders {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                    } else {
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                }
                
                // Stock
                Button(action: {toggle(type: "stock")}) {
                    if showingStocks {
                        Image(systemName: "dollarsign.square.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            
                    } else {
                        Image(systemName: "dollarsign.square")
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                }
            }
            .padding().padding().padding()
        }
    }
    
    func toggle(type: String) {
        if type == "insider" {
            self.showingStocks = false
            self.showingInsiders = true
        }
        
        if type == "stock" {
            self.showingStocks = true
            self.showingInsiders = false
        }
        
        if type == "description" {
            self.showingStocks = false
            self.showingInsiders = false
        }
    }
}

struct Selection_Previews: PreviewProvider {
    static var previews: some View {
        Selection(showingInsiders: .constant(false), showingStocks: .constant(true))
    }
}

/*
 
 */
