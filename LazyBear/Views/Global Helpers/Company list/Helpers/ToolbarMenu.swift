//
//  ToolbarMenu.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 25/4/21.
//

import SwiftUI

struct ToolbarMenu: View {
    @Binding var showRenameAction: Bool
    @Binding var showDeleteAlert: Bool
    
    var body: some View {
        Menu {
            Section {
                Button(action: { showRenameAction = true }) {
                    Label("Rename list", systemImage: "square.and.pencil")
                }
            }

            Section(header: Text("Secondary actions")) {
                Button(action: { showDeleteAlert = true }) {
                    Label("Delete list", systemImage: "trash")
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
        ToolbarMenu(showRenameAction: .constant(false), showDeleteAlert: .constant(false))
    }
}
