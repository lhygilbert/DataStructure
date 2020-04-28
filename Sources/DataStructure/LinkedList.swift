//
//  LinkedList.swift
//  
//
//  Created by Gilbert Lo on 4/26/20.
//

import Foundation

public final class LinkedList<Element> {
    
    private class Node<Element> {
        let item: Element?
        var next: Node<Element>?
        weak var prev: Node<Element>?
        
        init(item: Element?, next: Node<Element>? = nil, prev: Node<Element>? = nil) {
            self.item = item
            self.next = next
            self.prev = prev
        }
    }
    
    private let sentinel: Node<Element>
    private var size: Int
    
    /// The number of element in the list
    public var count: Int {
        return size
    }
    
    /// A Boolean value indicating whether the heap is empty.
    public var isEmpty: Bool {
        size == 0
    }
    
    /// The first element of the list
    public var first: Element? {
        return sentinel.next?.item
    }
    
    /// The last element of the list
    public var last: Element? {
        return sentinel.prev?.item
    }
    
    public init() {
        size = 0
        sentinel = Node(item: nil)
        sentinel.next = sentinel
        sentinel.prev = sentinel
    }
    
    /// Accesses the element at the specified position, error if index out of range
    /// - Parameter index: The position of the element to access
    /// - Returns: The element at the specified position
    /// - Complexity: O(n)
    public subscript(index: Int) -> Element {
        return node(at: index).item!
    }
    
    /// Inserts a new element into the list at the specified position.
    /// - Parameters:
    ///   - newElment: The new element to insert into the list.
    ///   - index: The position at which to insert the new element. index must be a valid index
    public func insert(_ newElment: Element, at index: Int) {
        if index == 0 {
            appendFirst(newElment)
        } else if index == size {
            appendLast(newElment)
        } else {
            let prevNode = node(at: index - 1)
            
            let newNode = Node(item: newElment, next: prevNode.next, prev: prevNode)
            prevNode.next = newNode
            size += 1
        }
    }
    
    /// Appends the specified element at the beginning of this list.
    /// - Parameter element: Element to be inserted at the beginning
    public func appendFirst(_ element: Element) {
        sentinel.next = Node(item: element, next: sentinel.next, prev: sentinel)
        // Change the old first node.prev point to new Node
        sentinel.next?.next?.prev = sentinel.next
        
        size += 1
    }
    
    /// Appends the specified element to the end of this list.
    /// - Parameter element: Element to be appended
    public func appendLast(_ element: Element) {
        let lastNode = sentinel.prev
        lastNode?.next = Node(item: element, next: sentinel, prev: lastNode)
        sentinel.prev = lastNode?.next
        
        size += 1
    }
    
    /// Removes all the elements from the list
    public func removeAll() {
        sentinel.next = sentinel
        sentinel.prev = sentinel
        size = 0
    }
    
    /// Removes and returns the elment at a specific index. Error if index out of range
    ///
    /// - Parameter index: Integer value of the index of the node to be removed
    /// - Returns: The data value contained in the deleted node
    @discardableResult public func remove(at index: Int) -> Element? {
        let nodeToRemove = node(at: index)
        
        let next = nodeToRemove.next
        let prev = nodeToRemove.prev
        
        prev?.next = next
        next?.prev = prev
        
        size -= 1
        return nodeToRemove.item
    }
    
    /// Removes and returns the element at the front of the list
    /// - Returns: Element at the front of the list
    @discardableResult public func removeFirst() -> Element? {
        return remove(at: 0)
    }
    
    /// Removes and returns the element at the end of the list
    /// - Returns: Element at the end of the list
    @discardableResult public func removeLast() -> Element? {
        return remove(at: size - 1)
    }
    
    // MARK: - Helper functions
    
    /// Returns the node at a specific index. Error if index out of range
    /// - Parameter index: Integer value of the index of the node
    /// - Returns: The node at the specific index
    private func node(at index: Int) -> Node<Element> {
        guard index >= 0 && index < size else {
            fatalError("Index out of range")
        }
        
        let midIndex = size / 2
        if index <= midIndex {
            var ptr = sentinel.next
            for _ in 0..<index {
                ptr = ptr?.next
            }
            return ptr!
        } else {
            var ptr = sentinel.prev
            for _ in 0..<(size - 1 - index) {
                ptr = ptr?.prev
            }
            return ptr!
        }
    }
    
}

// MARK: - ExpressibleByArrayLiteral Collection
extension LinkedList: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral: Element...) {
        self.init()
        for element in arrayLiteral {
            appendLast(element)
        }
    }
}

// MARK: - CustomStringConvertible Collection
extension LinkedList: CustomStringConvertible {
    public var description: String {
        var result = "["
        
        var ptr = sentinel.next
        while let value = ptr?.item {
            ptr = ptr?.next
            
            let separator = ptr === sentinel ? "" : ", "
            result += "\(value)\(separator)"
        }
        
        result.append("]")
        return result
    }
}

// MARK: - Collection Extension
extension LinkedList: Collection {
    public func index(after i: Int) -> Int {
        i + 1
    }
    
    public var startIndex: Int {
        0
    }
    
    public var endIndex: Int {
        size
    }
}
