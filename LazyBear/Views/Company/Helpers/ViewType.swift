//
//  ViewType.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 8/5/21.
//

import SwiftUI


class ViewSelector: ObservableObject {
    @Published var showChartView = false
    
    enum ViewType {
        case chart
    }
    
    func showView(_ viewType: ViewType) {
        switch viewType {
        case .chart:
            toogleVariables()
        }
    }
    
    private func toogleVariables() {
        // Testing this ////
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
//            let value = child.value
//            child.label = value
        }
        ////
    }
}
