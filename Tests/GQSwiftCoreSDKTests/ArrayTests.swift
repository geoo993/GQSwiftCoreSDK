import XCTest
@testable import GQSwiftCoreSDK

final class ArrayTests: XCTestCase {
    func test_safeSubscript() throws {
        let array: [String] = ["sam", "tom"]
        
        XCTAssertNil(array[safe: 3])
        
        let value = try XCTUnwrap(array[1])
        XCTAssertEqual(value, "tom")
    }
}
