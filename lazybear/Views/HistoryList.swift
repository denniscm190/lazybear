//
//  HistoryList.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/2/21.
//

import SwiftUI

struct HistoryList: View {
    @State private var showingActionSheet = false
    
    // <--------- Core Data --------->
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: RecentSearch.entity(), sortDescriptors: [])
    var history: FetchedResults<RecentSearch>
    // <--------- Core Data --------->
    
    var body: some View {
        if history.count > 0 {
            Section(header: Text("History"),
                    footer: Button(action: { self.showingActionSheet = true }
                    ) {
                        Text("Clear history").foregroundColor(.blue)
                            .actionSheet(isPresented: $showingActionSheet) { alert() }
                    }
            ) {
                // Sorte array by Date. The new ones come first in the list
                let sorted = history.sorted { $0.date ?? Date() > $1.date ?? Date() }
                ForEach(sorted) { company in
                    CompanyRow(history: company)
                }
            }
        }
    }
    
    private func delete() {
        for company in history {
            viewContext.delete(company)
        }
        do {
            try viewContext.save()
            print("History deleted")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func alert() -> ActionSheet {
        let action = ActionSheet(
            title: Text("Clear history"),
            message: Text("History will be cleared from your device"),
            buttons: [.cancel(Text("Cancel")), .destructive(Text("Clear history")) { delete() }])
        
        return action
    }
}

struct HistoryList_Previews: PreviewProvider {
    static var previews: some View {
        HistoryList()
    }
}
