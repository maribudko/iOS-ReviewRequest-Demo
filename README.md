Test asignment for iOS developer position

## Note
This project was initially implemented as a take-home assignment. I decided to keep it as a reference in my portfolio to demonstrate usage of StoreKit requestReview, Core Data session tracking, dependency injection (Swinject), and unit testing.

## Features:
- Tracks user sessions (Foreground / Background).
- Calculates total app usage time.
- Persists data with **Core Data** and **UserDefaults**.
- Triggers `SKStoreReviewController.requestReview` when conditions are met:
  - 2 completed sessions,
  - at least 10 minutes of usage,
  - no review requested in the last 3 days,
  - user opened the **Dummy** screen.

## TechStack
- Swift 5.9
- Core Data
- UserDefaults
- Dependency Injection (Swinject)
- Unit Tests (Swift Testing)
- SwiftLint (code style)
- Firebase Analytics

## Tests
- Unit tests are implemented using Swift Testing.
- Run tests via ⌘U in Xcode or through Product → Test.

## Code Style

- Enforced with SwiftLint.
- Configuration is available in .swiftlint.yml.
- Linting runs automatically on build.
