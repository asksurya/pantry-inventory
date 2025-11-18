import Foundation
import CoreData

class InventoryViewModel: ObservableObject {
    private let viewContext: NSManagedObjectContext

    @Published var items: [Item] = []
    @Published var errorMessage: String?
    @Published var showErrorAlert = false

    init(context: NSManagedObjectContext) {
        self.viewContext = context
    }

    func addItem(name: String, quantity: Double, quantityType: String, storageLocation: String, category: String, expirationDate: Date, purchaseDate: Date? = nil, notes: String? = nil, lowStockAlert: Bool = false, lowStockThreshold: Double = 0) {
        let newItem = Item(context: viewContext)
        newItem.itemName = name
        newItem.quantity = quantity
        newItem.quantityType = quantityType
        newItem.storageLocation = storageLocation
        newItem.category = category
        newItem.expirationDate = expirationDate
        newItem.purchaseDate = purchaseDate
        newItem.notes = notes
        newItem.lowStockAlert = lowStockAlert
        newItem.lowStockThreshold = lowStockThreshold
        newItem.createdAt = Date()

        do {
            try viewContext.save()
            fetchItems() // Refresh the items list
        } catch {
            let nsError = error as NSError
            errorMessage = "Failed to add item: \(nsError.localizedDescription)"
            showErrorAlert = true
        }
    }

    func fetchItems() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()

        do {
            items = try viewContext.fetch(request)
        } catch {
            let nsError = error as NSError
            errorMessage = "Failed to fetch items: \(nsError.localizedDescription)"
            showErrorAlert = true
        }
    }

    func deleteItems(at offsets: IndexSet) {
        offsets.map { items[$0] }.forEach(viewContext.delete)

        do {
            try viewContext.save()
            fetchItems()
        } catch {
            let nsError = error as NSError
            errorMessage = "Failed to delete item: \(nsError.localizedDescription)"
            showErrorAlert = true
        }
    }
}
