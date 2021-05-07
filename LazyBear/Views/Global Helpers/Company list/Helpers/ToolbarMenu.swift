//
//  ToolbarMenu.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/4/21.
//

import SwiftUI

struct ToolbarMenu: View {
    @Binding var showRenameListAction: Bool
    @Binding var showDeleteListAlert: Bool
    
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
    var watchlistCompany: FetchedResults<WatchlistCompany>
    
    var body: some View {
        Menu {
            Section {
                Button(action: { showRenameListAction = true }) {
                    Label("Rename list", systemImage: "square.and.pencil")
                }
            }
            
            // If there are only 1 watchlist -> It cannot be deleted
            if Set(watchlistCompany.map { $0.watchlist }).count > 1 {
                Section(header: Text("Secondary actions")) {
                    Button(action: { showDeleteListAlert = true }) {
                        Label("Delete list", systemImage: "trash")
                    }
                }
            }
        }
        label: {
            Label("Options", systemImage: "ellipsis.circle")
                .imageScale(.large)
        }
    }
}

struct ToolbarMenu_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarMenu(showRenameListAction: .constant(false), showDeleteListAlert: .constant(false))
    }
}
