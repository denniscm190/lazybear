//
//  HistoryList.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 7/2/21.
//

import SwiftUI

/*
 If the HistoryData is not empty => Show HistoryData. Else show a placeholder
 */

struct HistoryList: View {
    @State private var showingActionSheet = false
    
    // Core Data variables
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: HistoryData.entity(), sortDescriptors: [])
    var historyData: FetchedResults<HistoryData>
    
    var body: some View {
        if historyData.count > 0 {
            List {
                Section(header: Text("History"),
                        footer: Button(action: { self.showingActionSheet = true }
                        ) {
                            Text("Clear history").foregroundColor(.blue)
                                .actionSheet(isPresented: $showingActionSheet) { alert() }
                        }
                ) {
                    // Sore array by Date. The latest added to the list comes first
                    let sorted = historyData.sorted { $0.date ?? Date() > $1.date ?? Date() }
                    ForEach(sorted) { company in
                        CompanyRow(historyData: company)
                    }
                }
            }
        } else {
            Placeholder(title: "Try to search something!", text: "For example, type 'Apple' in the search bar")
            Spacer()
        }
    }
    
    private func delete() {
        for company in historyData {
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
