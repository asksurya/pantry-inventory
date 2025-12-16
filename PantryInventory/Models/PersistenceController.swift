import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.createdAt = Date()
            newItem.itemName = "Sample Item"
            newItem.quantity = 1
            newItem.quantityType = "Count"
            newItem.storageLocation = "Pantry"
            newItem.category = "Canned Goods"
            newItem.expirationDate = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // In a shipping application, this error should be handled appropriately (e.g., logging, alerting).
            // For the preview context (development only), a crash is useful to identify issues immediately.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PantryInventory")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // For now, we'll just print the error. A real app should use a robust logging framework.
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
