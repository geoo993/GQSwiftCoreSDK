import XCTest
@testable import GQSwiftCoreSDK

final class StringTests: XCTestCase {
    func test_isBlank() {
        var value = ""
        XCTAssertTrue(value.isEmpty)
        
        value = " "
        XCTAssertFalse(value.isEmpty)
        XCTAssertTrue(value.isBlank)
        
        value = "\t\r\n"
        XCTAssertFalse(value.isEmpty)
        XCTAssertTrue(value.isBlank)
    }
    
    func test_stringToUrl() {
        var value: String?
        XCTAssertNil(value.toUrl)
        
        value = "www.google.com"
        let result = value.toUrl
        XCTAssertNotNil(value.toUrl)
        XCTAssertEqual(result, URL(string: "www.google.com"))
    }
}
