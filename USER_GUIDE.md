# Pantry Inventory iOS App - User Guide

This guide provides instructions on how to build, run, and test the Pantry Inventory iOS application.

## Prerequisites

*   macOS with Xcode installed.
*   An iOS Simulator or a physical iOS device.

## Building and Running the Application

1.  **Clone the Repository**:
    ```bash
    git clone <repository_url>
    ```
2.  **Open the Project in Xcode**:
    *   Navigate to the project's root directory.
    *   Open the `Package.swift` file in Xcode.
3.  **Select a Simulator or Device**:
    *   In the top-left corner of the Xcode window, select the target device or simulator you want to run the app on.
4.  **Run the Application**:
    *   Press the "Run" button (the play icon) in the top-left corner of the Xcode window, or press `Cmd + R`.

## Testing the Application

The application uses XCTest for unit testing. The tests are located in the `PantryInventoryTests` directory.

### Running Tests in Xcode

1.  **Open the Test Navigator**:
    *   In the left-hand sidebar, click on the diamond icon to open the Test Navigator.
2.  **Run All Tests**:
    *   Click the "Run" button at the top of the Test Navigator to run all the tests.
3.  **Run Individual Tests**:
    *   To run a specific test, click the diamond icon next to the test class or test function.

### Running Tests from the Command Line

You can also run the tests from the command line using the `swift test` command in the project's root directory:

```bash
swift test
```

## How to Use the App

1.  **Launch the App**:
    *   Once the app is running, you will see the main inventory screen.
2.  **Add a New Item**:
    *   Tap the "+" button in the top-right corner of the screen.
    *   Fill in the item details in the form.
    *   Tap the "Add Item" button to save the item.
3.  **View Item Details**:
    *   The main screen will display a list of all the items in your inventory.
4.  **Delete an Item**:
    *   Swipe left on an item in the list to reveal the "Delete" button.
    *   Tap the "Delete" button to remove the item from your inventory.
