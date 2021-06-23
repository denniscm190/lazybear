//
//  UnwrapAnyOptional.swift
//  LazyBear
//
//  Created by Dennis Concepción Martín on 23/6/21.
//

import SwiftUI

/*
 Unwrap optional Int, Double, String into String
 */
func unwrapAnyOptional(value: Any) -> String? {
    if let value = value as? Int {
        return "\(value)"
    } else if let value = value as? Double {
        return String(format: "%.3f", value)
    } else {
        return value as? String
    }
}
