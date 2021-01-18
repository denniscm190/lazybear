//
//  LazyColumns.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 18/1/21.
//

import SwiftUI

// Change number of columns LazyGrid depending on the device
func lazyColumns(verticalSizeClass: UserInterfaceSizeClass, horizontalSizeClass: UserInterfaceSizeClass, iphoneColumns: Int, ipadColumns: Int) -> [GridItem] {
    var columns = [GridItem]()
    if horizontalSizeClass == .compact && verticalSizeClass == .regular {
        print("Running on iPhone")
        columns = Array(repeating: .init(.flexible()), count: iphoneColumns)
    }
    else if horizontalSizeClass == .regular && verticalSizeClass == .regular {
        print("Running on iPad")
        columns = Array(repeating: .init(.flexible()), count: ipadColumns)
    }
    
    return columns
    
}
