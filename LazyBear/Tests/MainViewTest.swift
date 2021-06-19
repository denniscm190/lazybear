//
//  MainViewTest.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 18/6/21.
//

import SwiftUI

class SheetManagement: ObservableObject {
    @Published var showDetailView = false
    @Published var showSubDetailview = false
}

struct MainViewTest: View {
    @StateObject var sheetManagement = SheetManagement()
    
    var body: some View {
        VStack {
            Text("Main View")
            Button("Show Sheet", action: { sheetManagement.showDetailView = true })
        }
        .sheet(isPresented: $sheetManagement.showDetailView) {
            DetailViewTest()
                .environmentObject(sheetManagement)
        }
    }
}

struct DetailViewTest: View {
    @EnvironmentObject var sheetManagement: SheetManagement
    
    var body: some View {
        VStack {
            Text("Detail View")
            Button("Show Sub Detail View", action: { sheetManagement.showSubDetailview = true })
        }
        .sheet(isPresented: $sheetManagement.showSubDetailview) {
            SubDetailViewTest()
                .environmentObject(sheetManagement)
        }
    }
}

struct SubDetailViewTest: View {
    @EnvironmentObject var sheetManagement: SheetManagement
    
    var body: some View {
        VStack {
            Text("Sub Detail View")
            Button("Hide everything", action: { sheetManagement.showDetailView = false; sheetManagement.showSubDetailview = false })
        }
    }
}
