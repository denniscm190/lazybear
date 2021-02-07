//
//  ViewSelector.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 6/2/21.
//

import SwiftUI

struct ViewSelector: View {
    @State private var showingActionSheet = false
    @Binding var viewSelected: Int
    
    var body: some View {
        Button(action: { self.showingActionSheet = true; print(self.showingActionSheet) }) {
            Image(systemName: "ellipsis")
                .imageScale(.large)
                .actionSheet(isPresented: $showingActionSheet) { alert() }
                
        }
    }
    
    private func alert() -> ActionSheet {
        let action = ActionSheet(
            title: Text("Views"),
            //message: Text("History will be claered from your device"),
            buttons: [.cancel(Text("Cancel")) { self.showingActionSheet = false },
                      .default(Text("Chart & news")) { self.viewSelected = 0 },
                      .default(Text("Insider transactions")) { self.viewSelected = 1 }
            ])
        
        return action
    }
}

struct ViewSelector_Previews: PreviewProvider {
    static var previews: some View {
        ViewSelector(viewSelected: .constant(1))
    }
}
