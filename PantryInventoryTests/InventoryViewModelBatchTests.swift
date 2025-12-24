import XCTest
import CoreData
@testable import PantryInventory

class InventoryViewModelBatchTests: XCTestCase {

    var persistenceController: PersistenceController!
    var viewContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        try super.setUpWithError()
        persistenceController = PersistenceController(inMemory: true)
        viewContext = persistenceController.container.viewContext
    }

    override func tearDownWithError() throws {
        persistenceController = nil
        viewContext = nil
        try super.tearDownWithError()
    }

    func testFetchRequestBatchSize() throws {
        let viewModel = InventoryViewModel(context: viewContext)

        // This method doesn't exist yet, but we are writing the test first (TDD).
        // It will be internal, so accessible via @testable import.
        let request = viewModel.makeFetchRequest()

        XCTAssertEqual(request.fetchBatchSize, 20, "Fetch batch size should be set to 20 to optimize memory usage.")
    }
}
