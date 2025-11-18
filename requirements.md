# Pantry Inventory iOS App - Product Requirements Document

## 1. Executive Summary

### 1.1 Product Vision

A household pantry inventory management app that helps families reduce food waste, avoid duplicate purchases, and enable better meal planning through intelligent tracking of food items across multiple storage locations.

### 1.2 Target Users

- **Phase 1**: Individual households (families sharing a single inventory)
- **Phase 2**: Broader consumer audience

### 1.3 Core Value Proposition

- Reduce food waste by tracking expiration dates
- Avoid duplicate purchases at grocery stores
- Enable meal planning based on available inventory
- Multi-user household collaboration with real-time sync

-----

## 2. Product Phases

### Phase 1 - Core Inventory Management (MVP)

- Item management (add, edit, delete, search)
- Photo recognition and barcode scanning
- Multi-user household accounts with sync
- Expiration and low-stock notifications
- Offline functionality with sync
- Basic inventory views and filtering

### Phase 2 - Intelligence & Planning

- Usage history and consumption patterns
- Shopping list integration
- Analytics dashboard
- Recipe lookup and meal planning
- Smart restocking suggestions

-----

## 3. Functional Requirements

### 3.1 User Management & Households

#### 3.1.1 Household Accounts

- Users can create or join a household
- Each household has a shared inventory visible to all members
- Multi-device real-time synchronization across all household members
- All household members have equal permissions (no role hierarchy)
- Users can belong to one household at a time in Phase 1

#### 3.1.2 Authentication

- Standard iOS authentication methods
- Support for Apple Sign-In
- Secure credential storage using iOS Keychain

### 3.2 Item Management

#### 3.2.1 Adding Items

**Input Methods:**

1. **Photo Recognition**
- Single item recognition: Take photo of individual item, AI identifies it
- Multi-item recognition: Snap photo of pantry shelf, recognize multiple items simultaneously
- On recognition failure:
  - Present “Try Again” button
  - Present “Enter Manually” button
  - Allow user to choose next action
1. **Barcode Scanning**
- Scan UPC/barcode for packaged goods
- Retrieve product information from product database
- Hybrid approach: Try external API first (Open Food Facts, UPC Database), fallback to manual entry
- Optional contribution to shared community database when adding manual details for unrecognized barcodes
- On scan failure:
  - Present “Try Again” button
  - Present “Enter Manually” button
1. **Manual Entry**
- Traditional form-based input for all item details

**Item Data Fields:**

- **Item Name** (required)
- **Quantity/Amount** (required - see 3.2.2)
- **Storage Location** (required)
- **Category** (auto-assigned, user-editable)
- **Expiration Date** (smart handling - see 3.2.3)
- **Purchase Date** (optional)
- **Item Photo** (captured during photo recognition, stored with item)
- **Notes** (optional)
- **Low Stock Alert** (optional toggle with optional threshold)

#### 3.2.2 Quantity Management

Support multiple quantity types based on item:

1. **Simple Count**: Whole numbers (3 cans, 2 boxes)
1. **Weight/Volume**: Specific measurements (2 lbs, 500g, 1 gallon, 250ml)
1. **Percentage**: For opened items (ketchup bottle 60% full)

Users select appropriate quantity type when adding item.

#### 3.2.3 Expiration Date Handling

Smart expiration date workflow:

1. **Photo/Barcode Detection**: Attempt to read expiration date from package photo or barcode database
1. **Smart Defaults**: Suggest typical shelf life based on item category/type
- Examples: Milk = 7 days, Canned goods = 2 years, Fresh produce = 3-5 days
1. **User Override**: Allow manual entry to override suggestions
1. **Optional Skip**: Prompt user with option to skip expiration date for non-perishables
1. **Required for Perishables**: Smart required fields - perishables require expiration date

#### 3.2.4 Storage Locations

**Default Locations:**

- Pantry
- Refrigerator
- Freezer
- Cabinet
- Counter

**Custom Locations:**

- Users can add custom storage locations (e.g., “Garage Freezer”, “Upstairs Closet”)
- Users can edit or delete custom locations
- Cannot delete default locations

#### 3.2.5 Categories

**Default Categories:**

- Produce (fruits & vegetables)
- Dairy & Eggs
- Meat & Seafood
- Grains & Pasta
- Canned Goods
- Condiments & Sauces
- Snacks
- Beverages
- Baking Supplies
- Frozen Foods
- Spices & Seasonings

**Category Management:**

- Auto-categorization when adding items via photo/barcode
- Users can change category assignment
- Users can add custom categories
- Users can edit or delete custom categories
- Cannot delete default categories

#### 3.2.6 Duplicate Item Handling

- Allow duplicate entries without warning
- Users can have multiple instances of same item (e.g., 2% milk and whole milk, or multiple locations)

### 3.3 Item Consumption & Updates

#### 3.3.1 Updating Quantities

Multiple update methods:

1. **Manual Adjustment**: Edit quantity field directly
1. **Quick Actions**: Swipe or tap button to quickly increment/decrement
1. **Percentage Update**: For percentage-based items, adjust percentage remaining
1. **Mark as Used**: Quick action to mark item as consumed

#### 3.3.2 Item Details Screen

Available actions:

- **Edit**: Modify any field
- **Adjust Quantity**: Quick +/- buttons
- **Move Location**: Quickly reassign to different storage
- **Share**: Share item details (text/email)
- **Delete**: Remove item
- **Add to Shopping List**: (Phase 2 placeholder)
- **View History**: (Phase 2 placeholder)

#### 3.3.3 Bulk Operations

Support multi-select for:

- Bulk delete
- Bulk location change
- Bulk category reassignment
- Bulk low stock toggle
- Bulk export

### 3.4 Search & Filtering

#### 3.4.1 Search

- Text search by item name
- Real-time search results as user types

#### 3.4.2 Filtering

- Filter by storage location
- Filter by category
- Filter by expiration status (expiring soon, expired, fresh)
- Combine multiple filters

#### 3.4.3 Sorting

- Sort by name (A-Z, Z-A)
- Sort by expiration date (soonest first, latest first)
- Sort by quantity (low to high, high to low)
- Sort by date added (newest, oldest)
- Sort by category
- Sort by location

### 3.5 Views & Display

#### 3.5.1 View Modes

Three view options user can toggle between:

1. **List View**: Scrollable list with key info per row (name, quantity, expiration, location)
1. **Grid/Card View**: Visual cards showing item photos in grid layout
1. **Grouped View**: Items organized by location or category with collapsible sections

#### 3.5.2 Item Display Information

Visible in list views:

- Item photo (if available)
- Item name
- Quantity with unit
- Expiration date with visual indicator (red for expired, yellow for expiring soon)
- Storage location
- Category
- Low stock indicator (if threshold met)

### 3.6 Notifications

#### 3.6.1 Expiration Alerts

Three-tier notification system:

- **1 month before** expiration
- **1 week before** expiration
- **1 day before** expiration

Notification settings:

- All household members receive all notifications
- Notifications delivered via iOS notification center
- Badge count on app icon for pending alerts

#### 3.6.2 Low Stock Alerts

- Simple toggle per item: “Notify when low stock”
- Optional threshold setting per item (e.g., alert when quantity reaches 1)
- Default behavior: Alert when item quantity reaches 0 or is marked as consumed

### 3.7 Data Safety & Recovery

#### 3.7.1 Undo Functionality

- Support undo for:
  - Item deletion
  - Item edits
  - Quantity changes
  - Bulk operations
- Undo available immediately after action (toast/snackbar with undo button)

#### 3.7.2 Recently Deleted

- Deleted items move to “Recently Deleted” folder
- Items remain in folder for 30 days
- Users can restore items from Recently Deleted
- Permanent deletion after 30 days or manual purge

#### 3.7.3 Deletion Confirmations

- Confirmation prompt before deleting items
- Confirmation for bulk delete operations
- Option to “Don’t ask again” for power users (can re-enable in settings)

#### 3.7.4 Backup & Export

**Auto Cloud Backup:**

- Automatic backup to iCloud
- Daily incremental backups
- Full backup on significant changes

**Manual Export:**

- Export inventory as CSV file
- Export inventory as Excel (XLSX) file
- Include all item data fields
- Option to filter export (by location, category, date range)
- Share exported file via standard iOS share sheet

### 3.8 Offline Functionality

#### 3.8.1 Offline Capabilities

- Full app functionality available offline
- Can add, edit, delete, search, filter items without internet
- Local database stores all data
- Photo recognition and barcode lookup require internet (graceful degradation)

#### 3.8.2 Sync Behavior

- Changes sync automatically when connection restored
- Visual sync indicator when syncing in progress
- Conflict resolution: timestamp-based (most recent change wins)
- If changes occur at exact same second: prompt user to choose which change to keep

### 3.9 Quick Access Features

#### 3.9.1 iOS Widgets

- Home screen widget showing items expiring soon (top 3-5)
- Quick “Add Item” button on widget
- Medium and large widget sizes

#### 3.9.2 Siri Shortcuts

- “Add [item] to pantry”
- “What’s expiring soon?”
- “How many [item] do I have?”
- “Show my pantry inventory”

#### 3.9.3 App Icon Quick Actions

- 3D Touch / Haptic Touch menu on app icon:
  - Scan barcode
  - Take photo of item
  - Add item manually
  - View expiring items

#### 3.9.4 In-App Quick Add

- Floating action button (FAB) for fast item entry
- Visible on main inventory screen
- Opens quick-add bottom sheet with input method choice

### 3.10 Onboarding

#### 3.10.1 First Launch Experience

1. Brief tutorial (3-4 screens) highlighting:
- Photo recognition and barcode scanning
- Multi-user household sync
- Expiration alerts
- Quick access features
1. Guided first item addition:
- Walk user through adding their first item
- Demonstrate photo or barcode scanning
- Show how to fill in item details
- Explain where to find item in inventory
1. Household setup:
- Create new household or join existing
- Invite household members

-----

## 4. Technical Requirements

### 4.1 Platform & Compatibility

#### 4.1.1 Operating System

- **Minimum iOS Version**: iOS 18+
- **Target Devices**: iPhone and iPad
- **iPad Support**: Optimized layouts for iPad (split view, larger canvas utilization)

#### 4.1.2 Camera Requirements

- Camera required for full experience (photo recognition & barcode scanning)
- Graceful degradation: Manual entry still available if camera access denied
- Request camera permissions with clear explanation of usage

### 4.2 Technology Stack (Industry Standards)

#### 4.2.1 Development Framework

- **UI Framework**: SwiftUI (primary), UIKit (for camera/complex interactions if needed)
- **Language**: Swift 6
- **Architecture**: MVVM (Model-View-ViewModel) with Combine for reactive programming

#### 4.2.2 Data & Storage

- **Local Database**: Core Data with CloudKit for iCloud sync
- **Offline Storage**: Core Data persistent store
- **Cloud Sync**: CloudKit for real-time multi-device synchronization
- **Image Storage**: Local file system with iCloud asset sync

#### 4.2.3 Camera & Recognition

- **Barcode Scanning**: AVFoundation with Vision framework
- **Photo Recognition**:
  - Core ML for on-device inference
  - Cloud-based ML API for complex recognition (Google Cloud Vision, AWS Rekognition, or Azure Computer Vision)
- **Image Processing**: Vision framework for image quality optimization

#### 4.2.4 External Services

- **Product Database API**: Open Food Facts API (primary), fallback to commercial UPC database
- **Push Notifications**: Apple Push Notification Service (APNs)
- **Analytics**: Apple App Analytics (built-in)

#### 4.2.5 Authentication

- **Sign In**: Sign in with Apple (primary), email/password (fallback)
- **Secure Storage**: iOS Keychain for credentials

### 4.3 Performance Requirements

#### 4.3.1 Performance Targets (Industry Standards)

- **App Launch Time**: < 2 seconds (cold start), < 0.5 seconds (warm start)
- **Photo Recognition**: < 3 seconds for results
- **Barcode Scanning**: < 1 second for recognition
- **Sync Speed**: < 5 seconds for changes to propagate across devices (on good connection)
- **List Scrolling**: 60fps with up to 1,000 items
- **Search Response**: < 0.5 seconds for results to appear

#### 4.3.2 Resource Usage

- **Memory**: Efficient memory management, no memory leaks
- **Battery**: Minimal background battery drain (< 1% per hour when not in use)
- **Storage**: Efficient image compression (target < 500KB per item photo)
- **Network**: Optimize API calls, batch requests when possible

### 4.4 Accessibility Requirements

#### 4.4.1 Standard iOS Accessibility

- **VoiceOver**: Full VoiceOver support for visually impaired users
- **Dynamic Type**: Support all iOS text size settings
- **High Contrast Mode**: Respect iOS high contrast settings
- **Reduce Motion**: Respect iOS reduce motion settings
- **Color Blindness**: Don’t rely solely on color for information (use icons/labels)

#### 4.4.2 Accessibility Testing

- Test with VoiceOver enabled
- Test with largest text size
- Verify all interactive elements have accessibility labels
- Ensure minimum touch target size (44x44 points)

### 4.5 Security & Privacy

#### 4.5.1 Data Privacy

- No collection of user data beyond what’s necessary for app functionality
- No selling or sharing of user data with third parties
- Clear privacy policy explaining data usage
- Option to delete all user data

#### 4.5.2 Data Security

- Encrypt data in transit (HTTPS/TLS)
- Encrypt sensitive data at rest (iOS Data Protection)
- Secure authentication token storage
- Regular security audits

-----

## 5. User Flows

### 5.1 First-Time User Flow

1. Launch app
1. View onboarding tutorial (3-4 screens)
1. Create account / Sign in with Apple
1. Create new household or join existing household
1. Grant camera permissions (with explanation)
1. Guided first item addition
1. Land on main inventory screen

### 5.2 Adding Item via Photo Recognition

1. Tap quick-add FAB or scan button
1. Select “Take Photo”
1. Point camera at item or shelf
1. Capture photo
1. Wait for AI recognition (< 3 seconds)
1. Review recognized item details (name, category)
1. Fill in/verify quantity, location, expiration
1. Save item
1. Return to inventory with new item visible

### 5.3 Adding Item via Barcode

1. Tap quick-add FAB or scan button
1. Select “Scan Barcode”
1. Point camera at barcode
1. Auto-scan when barcode detected
1. Retrieve product info from database
1. Review product details
1. Fill in quantity, location, expiration
1. Save item
1. Return to inventory

### 5.4 Consuming an Item

1. Navigate to inventory
1. Find item (search or browse)
1. Swipe item or tap to open details
1. Use quick decrement button OR adjust quantity
1. Confirm change
1. If quantity reaches low stock threshold, trigger notification
1. Return to updated inventory

### 5.5 Receiving Expiration Alert

1. Receive push notification (1 month/week/day before)
1. Tap notification
1. Open app to item details or filtered view of expiring items
1. User can:
- Consume item
- Update expiration date
- Delete item
- Add to shopping list (Phase 2)

### 5.6 Inviting Household Member

1. Open Settings / Household Management
1. Tap “Invite Member”
1. Enter email address or share invite link
1. Invited user receives notification
1. Accepts invite and joins household
1. Inventory immediately syncs to new member’s device

### 5.7 Searching & Filtering

1. Open inventory screen
1. Tap search bar
1. Type search term OR tap filter icon
1. Select filters (location, category, expiration)
1. View filtered results
1. Tap item to view details
1. Clear filters to return to full inventory

-----

## 6. UI/UX Specifications

### 6.1 Visual Design Principles

- Clean, minimalist interface
- Emphasis on item photos for easy visual scanning
- Clear typography with adequate spacing
- Consistent color coding:
  - Red: Expired items
  - Yellow/Orange: Expiring soon (< 1 week)
  - Green: Fresh items
  - Blue: Action buttons
  - Gray: Neutral/inactive states

### 6.2 Navigation Structure

```
Main Tabs (Bottom Navigation):
├── Inventory (Home)
│   ├── List/Grid/Grouped Views
│   ├── Search & Filter
│   └── Item Details
├── Notifications
│   ├── Expiring Soon
│   └── Low Stock
├── Settings
│   ├── Household Management
│   ├── Storage Locations
│   ├── Categories
│   ├── Notification Preferences
│   ├── Account Settings
│   └── Export Data
└── Quick Add (FAB - floating)
    ├── Take Photo
    ├── Scan Barcode
    └── Manual Entry
```

### 6.3 Key Screens

#### 6.3.1 Main Inventory Screen

- Top: Search bar and filter button
- View toggle (list/grid/grouped)
- Item list/grid with photos
- Floating action button (bottom right)
- Bottom tab navigation

#### 6.3.2 Item Details Screen

- Large item photo (top)
- Item name (editable)
- Quantity with +/- buttons
- Storage location (tappable to change)
- Category (tappable to change)
- Expiration date (tappable to change)
- Low stock toggle and threshold
- Notes section
- Action buttons: Edit, Move, Share, Delete

#### 6.3.3 Add Item Screen

- Input method selection (photo, barcode, manual)
- Camera view or form fields
- All item data fields
- Smart suggestions for category, expiration
- Save and Cancel buttons

#### 6.3.4 Notifications Screen

- Segmented control: Expiring / Low Stock
- List of items requiring attention
- Tap item to view details
- Quick actions: Consumed, Restocked, Ignore

### 6.4 iPad Optimizations

- Split view: Inventory list on left, item details on right
- Larger grid for grid view (4-5 columns vs 2-3 on iPhone)
- Sidebar navigation instead of bottom tabs
- Utilize extra screen space for filtering sidebar

-----

## 7. Phase 2 Features (Future Roadmap)

### 7.1 Usage History & Analytics

- Track consumption patterns (how quickly items are used)
- Dashboard with statistics:
  - Total items in inventory
  - Items expiring this week
  - Most consumed items
  - Food waste metrics
  - Storage utilization by location
- Predictive restocking suggestions

### 7.2 Shopping List Integration

- Auto-add low stock items to shopping list
- Manual add from inventory
- Categorize shopping list by store aisle
- Share shopping list with household members
- Check off items as purchased
- Auto-add to inventory when checked off

### 7.3 Recipe Integration

- Recipe lookup based on current inventory
- “What can I make?” feature
- Save favorite recipes
- Check ingredient availability
- Track ingredient usage when cooking
- Meal planning calendar

### 7.4 Advanced Features

- Barcode creation for custom items
- Price tracking and spending analytics
- Store integration (link to grocery store accounts)
- Nutrition information from product database
- Allergen tracking and warnings
- Expiration date prediction based on purchase date

-----

## 8. Success Metrics (KPIs)

### 8.1 Phase 1 Success Metrics

- **Adoption**: Number of households created
- **Engagement**: Daily/weekly active users
- **Retention**: 7-day, 30-day, 90-day retention rates
- **Feature Usage**:
  - % of items added via photo vs barcode vs manual
  - Average items per household
  - % of households with multiple members
- **Performance**: App crash rate < 0.1%
- **User Satisfaction**: App Store rating > 4.5 stars

### 8.2 Phase 2 Success Metrics (Future)

- Shopping list usage rate
- Recipe lookup frequency
- Food waste reduction (survey-based)
- Shopping efficiency improvement

-----

## 9. Constraints & Assumptions

### 9.1 Constraints

- iOS 18+ limits addressable market to newer devices
- Photo recognition accuracy dependent on image quality and ML model performance
- Barcode database coverage may be incomplete for local/niche products
- iCloud sync requires user to have iCloud account and storage space
- Camera is required for primary input methods

### 9.2 Assumptions

- Users have reliable internet connection for initial setup and sync
- Users are willing to grant camera permissions
- Household members trust each other (no permission restrictions needed)
- Product databases (Open Food Facts) remain accessible and free
- CloudKit provides sufficient free tier for typical household usage

-----

## 10. Open Questions & Future Considerations

### 10.1 Open Questions

- Should we support multiple household memberships in Phase 1 or Phase 2?
- What’s the maximum household size we should support?
- Should we add voice input as an additional input method?
- Should we integrate with smart home devices (e.g., smart fridges)?
- Should we support web version for desktop access?

### 10.2 Future Considerations

- Localization for international markets (non-English languages)
- Apple Watch companion app for quick views
- Apple Vision Pro spatial computing experience
- Integration with grocery delivery services (Instacart, Amazon Fresh)
- Community features (share recipes, pantry tips)
- Sustainability features (carbon footprint tracking, food donation suggestions)

-----

## 11. Glossary

- **Household**: A group of users sharing a single pantry inventory
- **Item**: A food or consumable product tracked in the pantry
- **Storage Location**: Physical location where items are stored (pantry, fridge, etc.)
- **Category**: Classification of items by type (dairy, produce, etc.)
- **Expiration Date**: Date when item expires or best-by date
- **Low Stock**: When item quantity reaches user-defined threshold or zero
- **Sync**: Process of synchronizing data across multiple devices
- **Quick Add**: Fast item entry via floating action button

-----

## Document History

|Version|Date      |Author |Changes                            |
|-------|----------|-------|-----------------------------------|
|1.0    |2025-11-17|Initial|Complete requirements specification|

-----

## Approval & Sign-off

*This section to be completed by stakeholders*

|Role          |Name|Signature|Date|
|--------------|----|---------|----|
|Product Owner |    |         |    |
|Technical Lead|    |         |    |
|Design Lead   |    |         |    |
|Stakeholder   |    |         |    |