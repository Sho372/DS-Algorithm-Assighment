import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(n_queens_problemTests.allTests),
    ]
}
#endif
