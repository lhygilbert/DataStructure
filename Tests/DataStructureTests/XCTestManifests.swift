import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(HeapTests.allTests),
        testCase(LinkedListTests.allTests)
    ]
}
#endif
