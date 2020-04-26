//
//  Collection+Extension.swift
//  
//
//  Created by Gilbert Lo on 4/25/20.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
