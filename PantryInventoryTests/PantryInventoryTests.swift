import XCTest
import CoreData
@testable import PantryInventory

class PantryInventoryTests: XCTestCase {

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

    func testAddItem() throws {
        let viewModel = InventoryViewModel(context: viewContext)

        let initialCount = try viewContext.count(for: Item.fetchRequest())
        XCTAssertEqual(initialCount, 0, "Initial item count should be 0")

        viewModel.addItem(
            name: "Milk",
            quantity: 1.0,
            quantityType: "Gallon",
            storageLocation: "Refrigerator",
            category: "Dairy & Eggs",
            expirationDate: Date().addingTimeInterval(86400 * 7) // 7 days from now
        )

        let finalCount = try viewContext.count(for: Item.fetchRequest())
        XCTAssertEqual(finalCount, 1, "Item count should be 1 after adding an item")

        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "itemName == %@", "Milk")

        let items = try viewContext.fetch(fetchRequest)
        XCTAssertEqual(items.count, 1, "There should be one item named 'Milk'")

        let item = items.first!
        XCTAssertEqual(item.itemName, "Milk")
        XCTAssertEqual(item.quantity, 1.0)
        XCTAssertEqual(item.quantityType, "Gallon")
        XCTAssertEqual(item.storageLocation, "Refrigerator")
        XCTAssertEqual(item.category, "Dairy & Eggs")
    }

    func testFetchItems() throws {
        let viewModel = InventoryViewModel(context: viewContext)

        viewModel.addItem(
            name: "Bread",
            quantity: 1.0,
            quantityType: "Loaf",
            storageLocation: "Pantry",
            category: "Grains & Pasta",
            expirationDate: Date().addingTimeInterval(86400 * 5)
        )

        viewModel.addItem(
            name: "Eggs",
            quantity: 12.0,
            quantityType: "Count",
            storageLocation: "Refrigerator",
            category: "Dairy & Eggs",
            expirationDate: Date().addingTimeInterval(86400 * 14)
        )

        viewModel.fetchItems()

        XCTAssertEqual(viewModel.items.count, 2, "There should be 2 items in the inventory")

        let bread = viewModel.items.first { $0.itemName == "Bread" }
        XCTAssertNotNil(bread)

        let eggs = viewModel.items.first { $0.itemName == "Eggs" }
        XCTAssertNotNil(eggs)
    }

    func testDeleteItem() throws {
        let viewModel = InventoryViewModel(context: viewContext)

        viewModel.addItem(
            name: "Milk",
            quantity: 1.0,
            quantityType: "Gallon",
            storageLocation: "Refrigerator",
            category: "Dairy & Eggs",
            expirationDate: Date()
        )

        viewModel.addItem(
            name: "Cereal",
            quantity: 1.0,
            quantityType: "Box",
            storageLocation: "Pantry",
            category: "Grains & Pasta",
            expirationDate: Date()
        )

        viewModel.fetchItems()
        XCTAssertEqual(viewModel.items.count, 2)

        let milk = viewModel.items.first { $0.itemName == "Milk" }!
        let milkIndex = viewModel.items.firstIndex(of: milk)!

        viewModel.deleteItems(at: IndexSet(integer: milkIndex))

        XCTAssertEqual(viewModel.items.count, 1)

        let remainingItem = viewModel.items.first!
        XCTAssertEqual(remainingItem.itemName, "Cereal")
    }
}
