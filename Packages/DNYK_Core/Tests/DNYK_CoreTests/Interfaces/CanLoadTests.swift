import XCTest

@testable import DNYK_Core

class CanLoadTests: XCTestCase {
    var canLoad: (any ICanLoad)!
    
    class MockCanLoad: ICanLoad {
        var isLoading: Bool = false
    }
    
    override func setUp() {
        super.setUp()
        canLoad = MockCanLoad()
    }
    
    func testToggleLoadingWithoutParameters() async {
        await canLoad.toggleLoading()
        XCTAssertTrue(canLoad.isLoading)
        
        await canLoad.toggleLoading()
        XCTAssertFalse(canLoad.isLoading)
    }
    
    func testToggleLoadingWithParameters() async {
        await canLoad.toggleLoading(true)
        XCTAssertTrue(canLoad.isLoading)
        
        await canLoad.toggleLoading(false)
        XCTAssertFalse(canLoad.isLoading)
    }
}
