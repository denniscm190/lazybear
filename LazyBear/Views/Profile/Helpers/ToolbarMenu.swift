//
//  ToolbarMenu.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 18/6/21.
//

import SwiftUI

struct ToolbarMenu: View {
    @Binding var showRenameListSheet: Bool
    @Binding var showDeleteListAlert: Bool
    
    @FetchRequest(entity: WatchlistCompany.entity(), sortDescriptors: [])
    var watchlistCompany: FetchedResults<WatchlistCompany>
    
    var body: some View {
        Menu {
            Section {
                Button(action: { showRenameListSheet = true }) {
                    Label("Rename list", systemImage: "square.and.pencil")
                }
            }
            
            if Set(watchlistCompany.map { $0.watchlistName }).count > 1 {  /// If there are only 1 watchlist (default) -> It cannot be deleted
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
        ToolbarMenu(showRenameListSheet: .constant(false), showDeleteListAlert: .constant(false))
    }
}
