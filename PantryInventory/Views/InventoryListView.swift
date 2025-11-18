import SwiftUI
import CoreData

struct InventoryListView: View {
    @StateObject private var viewModel: InventoryViewModel
    @State private var showingAddItemView = false

    init(context: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: InventoryViewModel(context: context))
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) { item in
                    VStack(alignment: .leading) {
                        Text(item.itemName ?? "Unknown Item")
                            .font(.headline)
                        Text("Quantity: \(item.quantity) \(item.quantityType ?? "")")
                            .font(.subheadline)
                        Text("Expires on: \(item.expirationDate ?? Date(), formatter: itemFormatter)")
                            .font(.caption)
                            .foregroundColor(expirationColor(for: item.expirationDate))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Pantry Inventory")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: { showingAddItemView.toggle() }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddItemView) {
                AddItemView(viewModel: viewModel)
            }
            .onAppear(perform: viewModel.fetchItems)
            .alert(isPresented: $viewModel.showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? "An unknown error occurred."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            viewModel.deleteItems(at: offsets)
        }
    }

    private func expirationColor(for date: Date?) -> Color {
        guard let date = date else { return .primary }

        if date < Date() {
            return .red
        } else if let oneWeekFromNow = Calendar.current.date(byAdding: .day, value: 7, to: Date()), date < oneWeekFromNow {
            return .orange
        } else {
            return .green
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()
