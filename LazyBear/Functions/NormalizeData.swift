//
//  NormalizeData.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 18/3/21.
//

import SwiftUI

func normalize(_ data: [Double]) -> [Double] {
    var normalData = [Double]()
    let min = data.min()!
    let max = data.max()!

    for value in data {
        let normal = (value - min) / (max - min)
        normalData.append(normal)
    }

    return normalData
}
