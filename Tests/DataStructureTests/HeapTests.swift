//
//  HeapTests.swift
//  
//
//  Created by Gilbert Lo on 4/25/20.
//

import XCTest
@testable import DataStructure

final class HeapTests: XCTestCase {
    
    func testCount() {
        var heap = Heap<Int>(order: <)
        XCTAssertEqual(0, heap.count)
        heap.insert(1)
        XCTAssertEqual(1, heap.count)
        heap.insert(1)
        XCTAssertEqual(2, heap.count)
    }
    
    func testIsEmpty() {
        var heap = Heap<Int>(order: <)
        XCTAssert(heap.isEmpty)
        heap.insert(1)
        XCTAssertFalse(heap.isEmpty)
    }
    
    func testMinHeap() {
        var minHeap = Heap<Int>(order: <)
        
        let nums = [3, 4, 2, 6, 7, 1, 8, 5]
        for num in nums {
            minHeap.insert(num)
        }
        
        XCTAssertEqual(8, minHeap.count)
        XCTAssertFalse(minHeap.isEmpty)
        XCTAssertEqual(1, minHeap.peek())
        
        for num in nums.sorted() {
            XCTAssertEqual(num, minHeap.remove())
        }
    }
    
    func testMaxHeap() {
        var maxHeap = Heap<Int>(order: >)
        
        let nums = [3, 4, 2, 6, 7, 1, 8, 5]
        for num in nums {
            maxHeap.insert(num)
        }
        
        XCTAssertEqual(8, maxHeap.count)
        XCTAssertFalse(maxHeap.isEmpty)
        XCTAssertEqual(8, maxHeap.peek())
        
        for num in nums.sorted(by: >) {
            XCTAssertEqual(num, maxHeap.remove())
        }
    }

    static var allTests = [
        ("testCount", testCount),
        ("testIsEmpty", testIsEmpty),
        ("testMinHeap", testMinHeap)
    ]
}
