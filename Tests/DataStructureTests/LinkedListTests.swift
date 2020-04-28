//
//  LinkedListTests.swift
//  
//
//  Created by Gilbert Lo on 4/26/20.
//

import XCTest
@testable import DataStructure

final class LinkedListTests: XCTestCase {
    
    func testCount() {
        let list = LinkedList<Int>()
        XCTAssertEqual(list.count, 0)        
        list.appendFirst(2)
        list.appendLast(5)
        list.appendFirst(1)
        list.appendLast(6)
        XCTAssertEqual(list.count, 4)
    }
    
    func testIsEmpty() {
        let list = LinkedList<String>()
        XCTAssert(list.isEmpty)
        list.appendLast("str")
        XCTAssertFalse(list.isEmpty)
    }
    
    func testFirstAndLast() {
        let list = LinkedList<Int>()
        XCTAssertNil(list.first)
        XCTAssertNil(list.last)
        list.appendFirst(5)
        list.appendLast(6)
        XCTAssertEqual(list.first, 5)
        XCTAssertEqual(list.last, 6)
    }
    
    func testSubscript() {
        let list = LinkedList<Int>()
        list.appendFirst(2)
        list.appendLast(5)
        list.appendLast(6)
        
        XCTAssertEqual(list[0], 2)
        XCTAssertEqual(list[1], 5)
        XCTAssertEqual(list[2], 6)
    }
    
    func testInsert() {
        let list = LinkedList<Int>()
        list.insert(3, at: 0)
        list.insert(1, at: 0)
        list.insert(2, at: 1)
        XCTAssertEqual(list.first, 1)
        XCTAssertEqual(list.last, 3)
        XCTAssertEqual(list.count, 3)
        
        XCTAssertEqual(list.removeFirst(), 1)
        XCTAssertEqual(list.first, 2)
    }
    
    func testRemoveAll() {
        let list = LinkedList<Int>()
        list.appendFirst(2)
        list.appendLast(5)
        
        list.removeAll()
        XCTAssert(list.isEmpty)
        XCTAssertEqual(list.count, 0)
        
        list.appendFirst(1)
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.first, 1)
    }
    
    func testRemove() {
        let list = LinkedList<Int>()
        list.appendFirst(2)
        list.appendLast(5)
        list.appendLast(6)
        list.appendFirst(1)
        
        XCTAssertEqual(list.remove(at: 2), 5)
        XCTAssertEqual(list.first, 1)
        XCTAssertEqual(list.last, 6)
        XCTAssertEqual(list.count, 3)
    }
    
    func testRemoveFirst() {
        let list = LinkedList<Int>()
        list.appendFirst(2)
        list.appendLast(5)
        list.appendFirst(1)
        list.appendLast(6)
        
        XCTAssertEqual(list.removeFirst(), 1)
        XCTAssertEqual(list.count, 3)
        XCTAssertEqual(list.removeFirst(), 2)
        XCTAssertEqual(list.count, 2)
        XCTAssertEqual(list.removeFirst(), 5)
        XCTAssertEqual(list.count, 1)
        XCTAssertEqual(list.removeFirst(), 6)
        XCTAssertEqual(list.count, 0)
    }
    
    func testRemoveLast() {
        let list = LinkedList<Int>()
        list.appendFirst(2)
        list.appendLast(5)
        list.appendFirst(1)
        list.appendLast(6)
        
        XCTAssertEqual(list.removeLast(), 6)
        XCTAssertEqual(list.count, 3)
        XCTAssertEqual(list.removeLast(), 5)
        XCTAssertEqual(list.count, 2)
        XCTAssertEqual(list.removeLast(), 2)
        XCTAssertEqual(list.count, 1)
        XCTAssertEqual(list.removeLast(), 1)
        XCTAssertEqual(list.count, 0)
    }
    
    func testExpressibleByArrayLiteral() {
        let list: LinkedList = ["a", "b", "c"]
        
        XCTAssertEqual(list[0], "a")
        XCTAssertEqual(list[1], "b")
        XCTAssertEqual(list[2], "c")
        XCTAssertEqual(list.first, "a")
        XCTAssertEqual(list.last, "c")
    }
    
    func testCollectionExtension() {
        let arr = [1, 2, 3, 4, 5, 6]
        
        let list: LinkedList = [1, 2, 3, 4, 5, 6]
        let testIndex = list.index(list.startIndex, offsetBy: 3)
        XCTAssertEqual(list[testIndex], 4)
        
        for (index, elem) in list.enumerated() {
            XCTAssertEqual(arr[index], elem)
        }
    }

    static var allTests = [
        ("testCount", testCount),
        ("testRemoveFirst", testRemoveFirst),
        ("testFirstAndLast", testFirstAndLast),
        ("testSubscript", testSubscript),
        ("testInsert", testInsert),
        ("testRemoveAll", testRemoveAll),
        ("testRemove", testRemove),
        ("testRemoveFirst", testRemoveFirst),
        ("testRemoveLast", testRemoveLast),
        ("testExpressibleByArrayLiteral", testExpressibleByArrayLiteral),
        ("testCollectionExtension", testCollectionExtension),
    ]
}
