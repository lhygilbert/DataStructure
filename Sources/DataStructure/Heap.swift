//
//  Heap.swift
//  
//
//  Created by Gilbert Lo on 4/25/20.
//

import Foundation

public struct Heap<Element> {
    private var nodes = [Element]()
    private let order: (Element, Element) -> Bool
    
    /// The number of element in the heap
    public var count: Int {
        nodes.count
    }
    
    /// A Boolean value indicating whether the heap is empty.
    public var isEmpty: Bool {
        nodes.isEmpty
    }
    
    public init(order: @escaping (Element, Element) -> Bool) {
        self.order = order
    }
    
    /// Return the max/min (based on given order) element in the heap
    /// - Returns: Max/Min (based on given order) element in the heap
    public func peek() -> Element? {
        return nodes.first
    }
    
    /// Add an elment to the heap
    /// - Parameter element: The element to add to the heap
    /// - Complexity: O(log N)
    public mutating func insert(_ element: Element) {
        nodes.append(element)
        swim(index: nodes.count - 1)
    }
    
    /// Remove and return the max/min (based on given order) element in the heap
    /// - Returns: Max/Min (based on given order) element in the heap
    /// - Complexity: O(log N)
    @discardableResult
    public mutating func remove() -> Element? {
        guard let val = nodes.first else { return nil }
        if nodes.count == 1 {
            nodes.removeLast()
        } else {
            nodes[0] = nodes.removeLast()
            sink(index: 0)
        }
        return val
    }
    
    // MARK: Private Helper functions
    
    private static func parentIndex(of index: Int) -> Int {
        return (index - 1) / 2
    }
    
    private static func leftChildIndex(of index: Int) -> Int {
        return 2 * index + 1
    }
    
    private static func rightChildIndex(of index: Int) -> Int {
        return 2 * index + 2
    }
    
    /// Bubbles up the element currently at the given index.
    /// - Parameter index: index to bubble up
    private mutating func swim(index: Int) {
        var index = index
        var parentIndex = Heap.parentIndex(of: index)
        
        while index > 0 && order(nodes[index], nodes[parentIndex]) {
            nodes.swapAt(index, parentIndex)
            index = parentIndex
            parentIndex = Heap.parentIndex(of: index)
        }
    }
    
    /// Bubbles down the element currently at the given index.
    /// - Parameter index: index to bubble down
    private mutating func sink(index: Int) {
        var index = index
        var leftChildIndex = Heap.leftChildIndex(of: index)
        var righChildIndex = Heap.rightChildIndex(of: index)
        
        while (perferIndex(index1: index, index2: leftChildIndex) != index) ||
            (perferIndex(index1: index, index2: righChildIndex) != index)
        {
            guard let swapIndex = perferIndex(index1: leftChildIndex, index2: righChildIndex) else { break }
            nodes.swapAt(index, swapIndex)
            index = swapIndex
            leftChildIndex = Heap.leftChildIndex(of: index)
            righChildIndex = Heap.rightChildIndex(of: index)
        }
    }
    
    /// Returns the index of the element that comes first by the order function
    /// - Parameters:
    ///   - index1: First index to compare
    ///   - index2: Second index to compare
    /// - Returns: index of the element that comes first by the order function, nil if both index1 and index2 are out of range
    private func perferIndex(index1: Int, index2: Int) -> Int? {
        let node1 = nodes[safe: index1]
        let node2 = nodes[safe: index2]
        
        guard node1 != nil || node2 != nil else { return nil }
        
        if let n1 = node1, let n2 = node2 {
            return order(n1, n2) ? index1 : index2
        } else if node1 == nil {
            return index2
        } else {
            return index1
        }
    }
    
}
