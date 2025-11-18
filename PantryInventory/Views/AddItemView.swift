import SwiftUI

struct AddItemView: View {
    @ObservedObject var viewModel: InventoryViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var itemName = ""
    @State private var quantity = ""
    @State private var quantityType = "Count"
    @State private var storageLocation = "Pantry"
    @State private var category = "Canned Goods"
    @State private var expirationDate = Date()
    @State private var purchaseDate = Date()
    @State private var notes = ""
    @State private var lowStockAlert = false
    @State private var lowStockThreshold = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    private let quantityTypes = ["Count", "lbs", "kg", "gallons", "liters", "Percentage"]
    private let storageLocations = ["Pantry", "Refrigerator", "Freezer", "Cabinet", "Counter"]
    private let categories = ["Produce", "Dairy & Eggs", "Meat & Seafood", "Grains & Pasta", "Canned Goods", "Condiments & Sauces", "Snacks", "Beverages", "Baking Supplies", "Frozen Foods", "Spices & Seasonings"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Item Details")) {
                    TextField("Item Name", text: $itemName)
                    TextField("Quantity", text: $quantity)
                        .keyboardType(.decimalPad)
                    Picker("Quantity Type", selection: $quantityType) {
                        ForEach(quantityTypes, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section(header: Text("Storage & Category")) {
                    Picker("Storage Location", selection: $storageLocation) {
                        ForEach(storageLocations, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("Category", selection: $category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section(header: Text("Dates")) {
                    DatePicker("Purchase Date", selection: $purchaseDate, displayedComponents: .date)
                    DatePicker("Expiration Date", selection: $expirationDate, displayedComponents: .date)
                }

                Section(header: Text("Optional Information")) {
                    TextField("Notes", text: $notes)
                    Toggle("Low Stock Alert", isOn: $lowStockAlert)
                    if lowStockAlert {
                        TextField("Low Stock Threshold", text: $lowStockThreshold)
                            .keyboardType(.decimalPad)
                    }
                }

                Button(action: addItem) {
                    Text("Add Item")
                }
            }
            .navigationTitle("Add New Item")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(alertTitle),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    private func addItem() {
        if itemName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            alertTitle = "Invalid Item Name"
            alertMessage = "Please enter a name for the item."
            showingAlert = true
            return
        }

        guard let quantityValue = Double(quantity) else {
            alertTitle = "Invalid Quantity"
            alertMessage = "Please enter a valid number for the quantity."
            showingAlert = true
            return
        }

        viewModel.addItem(
            name: itemName,
            quantity: quantityValue,
            quantityType: quantityType,
            storageLocation: storageLocation,
            category: category,
            expirationDate: expirationDate,
            purchaseDate: purchaseDate,
            notes: notes,
            lowStockAlert: lowStockAlert,
            lowStockThreshold: Double(lowStockThreshold) ?? 0
        )

        presentationMode.wrappedValue.dismiss()
    }
}
