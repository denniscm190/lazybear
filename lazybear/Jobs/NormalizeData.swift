//
//  normalize.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 31/1/21.
//

import Foundation

func normalize(_ data: [Double]) -> [DataPoint] {
    var normalData = [DataPoint]()
    let min = data.min()!
    let max = data.max()!
    
    for value in data {
        let normal = (value - min) / (max - min)
        normalData.append(DataPoint(value: normal))
    }
    
    return normalData
}
