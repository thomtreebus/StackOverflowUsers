# StackOverflow Users
A simple iOS app that displays a list of the top 20 StackOverflow users, allowing users to follow their favorite StackOverflow contributors. It's built with SwiftUI and follows the MVVM (Model-View-ViewModel) architectural pattern.

## Features

- When the app is opened, a request is made to the StackOverflow API to fetch the top 20 StackOverflow users.
- Displays the top 20 StackOverflow users based on reputation
- Shows user profile image, name, and reputation for each user
- Allows following/unfollowing users (locally simulated)
- Persists follow status between app sessions
- Shows appropriate error messages when network is unavailable

List of Users            |  Error View
:-------------------------:|:-------------------------:
![Simulator Screenshot - iPhone 15 Pro - 2025-02-23 at 12 33 03](https://github.com/user-attachments/assets/fa5ac57c-2a7f-4db3-9084-e30c0e72e837) |  ![Simulator Screenshot - iPhone 15 Pro - 2025-02-22 at 14 28 04](https://github.com/user-attachments/assets/5a1bdca3-1d96-4659-a184-21a85e09a827)





## Installation and Usage

1. Clone the repository

```
git clone git@github.com:thomtreebus/StackOverflowUsers.git
```

2. Open the project in Xcode
3. Build and run the application using an iPhone simulator (needs to be at least iOS 15)

### Architecture

The app follows the **MVVM (Model-View-ViewModel)** architecture pattern:

- **Model**: `User` data modelm conforms to Codable for API response parsing
- **View**: SwiftUI views (`UserListView`, `UserRow`, `ErrorView`) for UI components
- **ViewModel**: `UserListViewModel` for business logic and data transformation
- **Services**: `NetworkService` for API communication and `UserStore` for persistence (using UserDefaults)

### Key Components

1. **NetworkService**: Responsible for fetching user data from the StackOverflow API
   - Uses Swift's modern async/await pattern for cleaner asynchronous code
   - Implements comprehensive error handling
   - Protocol-based design for testability

2. **UserStore**: Manages the local "follow" state for users
   - Implements the `ObservableObject` protocol for SwiftUI integration
   - Persists followed users using UserDefaults
   - Provides methods to follow, unfollow, and check follow status

3. **UserListViewModel**: Central ViewModel that:
   - Coordinates between the NetworkService and UserStore
   - Publishes changes to the view through the @Published property wrapper

4. **SwiftUI Views**:
   - `UserListView`: Main view that displays the list of users
   - `UserRow`: Displays individual user information and follow button
   - `ErrorView`: Shows error messages with a retry option

### Design Decisions

**SwiftUI**: My preferred framework, works well for simple apps like this one
**MVVM Architecture**: Chosen for better testability and to make the code more modular. It's also pretty standard when using SwiftUI
**Protocol-Based Design**: Implemented for services to enable dependency injection for testing and to make mocking easier

## Testing

The app includes unit tests for all major components. XCTest was used to write the tests. I created mocks for each component in order to test them. 
Run tests using Cmd+U in Xcode or through the Test Navigator.
