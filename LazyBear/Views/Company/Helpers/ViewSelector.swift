//
//  ViewType.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 8/5/21.
//

import SwiftUI


class ViewSelector: ObservableObject {
    @Published var views = [
        "chart": true
    ]
    
    enum ViewType {
        case chart
    }
    
    func showView(_ viewType: ViewType) {
        switch viewType {
        case .chart:
            toogleVariables()
            views["chart"] = true
        }
    }
    
    /*
     Change to false views
     */
    private func toogleVariables() {
        for view in views.keys {
            views[view] = false
        }
    }
}
