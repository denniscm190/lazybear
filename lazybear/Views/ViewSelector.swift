//
//  ViewSelector.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 6/2/21.
//

import SwiftUI

/*
 When AddButton is tapped the following options will be shown
 */

struct ViewSelector: View {
    @State private var showingActionSheet = false
    @Binding var viewSelected: Int
    
    var body: some View {
        Button(action: { self.showingActionSheet = true }) {
            Image(systemName: "ellipsis")
                .imageScale(.large)
                .frame(width: 30, height: 30)  // Increase tappable area
                .actionSheet(isPresented: $showingActionSheet) { alert() }
                
        }
    }
    
    // Create action sheet
    private func alert() -> ActionSheet {
        let action = ActionSheet(
            title: Text("Views"),
            buttons: [.cancel(Text("Cancel")) { self.showingActionSheet = false },
                      .default(Text("Chart & news")) { self.viewSelected = 0 },
                      .default(Text("Insiders")) { self.viewSelected = 1 }
            ])
        
        return action
    }
}

struct ViewSelector_Previews: PreviewProvider {
    static var previews: some View {
        ViewSelector(viewSelected: .constant(1))
    }
}
