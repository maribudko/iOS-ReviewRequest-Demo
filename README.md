Test asignment for iOS developer position

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

## Tests
- Unit tests are implemented using Swift Testing.
- Run tests via ⌘U in Xcode or through Product → Test.

## Code Style

- Enforced with SwiftLint.
- Configuration is available in .swiftlint.yml.
- Linting runs automatically on build.
