import XCTest
@testable import PantryInventory

class PersistenceControllerTests: XCTestCase {

    func testPreviewContextInitialization() {
        // Accessing the preview property should not crash
        let previewController = PersistenceController.preview
        XCTAssertNotNil(previewController)
        XCTAssertNotNil(previewController.container)
        XCTAssertTrue(previewController.container.viewContext.concurrencyType == .mainQueueConcurrencyType)
    }
}
