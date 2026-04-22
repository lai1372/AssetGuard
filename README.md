# Asset Guard

Asset Guard is a cross-platform Flutter application built for Meridian Field Services Ltd's field engineers to manage inspection data with offline-first capability. Create, edit, and delete reports that sync seamlessly when you're back online.

## Features

- **User Authentication**: Secure login via Firebase Auth
- **Offline-First Architecture**: Work offline, sync automatically when connected
- **Create Reports**: Add new asset reports with title and description
- **Edit Reports**: Update existing reports
- **Delete Reports**: Remove reports with confirmation
- **Real-time Sync**: Cloud Firestore integration for data persistence
- **Connectivity Awareness**: Clear offline indicator banner

## Platform Support

Asset Guard is available on:

- **macOS**
- **Android**

## Prerequisites

- Flutter 3.11.4 or higher
- Dart 3.11.4 or higher
- For Android: Android SDK
- For macOS: Xcode and CocoaPods

## Installation

1. Clone the repository:

   ```bash
   git clone <repository-url>
   cd asset_guard
   ```

2. Get dependencies:

   ```bash
   flutter pub get
   ```

3. Configure Firebase (required for authentication and data persistence):
   - Follow the [Firebase setup guide](https://firebase.google.com/docs/flutter/setup)
   - Ensure `google-services.json` (Android) and `GoogleService-Info.plist` (macOS) are configured

## Running the App

### macOS

```bash
flutter run -d macos
```

### Android

```bash
flutter run -d android
```

### Run on specific device

```bash
flutter devices  # List available devices
flutter run -d <device-id>
```

## Running Tests

### Unit Tests

```bash
flutter test test/unit
```

### Integration Tests

```bash
flutter test test/integration
```

### All Tests

```bash
flutter test
```

## App Usage

1. **Login**: Enter your credentials to authenticate
2. **View Reports**: Browse all your reports on the home screen
3. **Create Report**: Tap the floating action button to create a new report
   - Enter a title (3-100 characters)
   - Enter a description (10-1000 characters)
   - Report is saved locally and synced when online
4. **Edit Report**: Tap a report to view details, then edit
5. **Delete Report**: Tap a report and use the delete option with confirmation
6. **Offline Mode**: An orange banner indicates offline status; changes are queued and sync when reconnected
7. **Profile**: Tap the person icon to view your profile and logout

## Architecture

Asset Guard uses an **offline-first architecture**:

- UI operations are synchronous for immediate feedback
- Repository layer handles all async operations
- Local cache is the source of truth
- Background sync occurs automatically when online
- Firestore provides cloud persistence

## Development

### Code Structure

```
lib/
├── main.dart              # App entry point
├── api/                   # API client for Firebase
├── models/                # Data models (Report)
├── repositories/          # Business logic layer
└── screens/               # UI screens
    ├── home_screen.dart
    ├── create_report_screen.dart
    ├── edit_report_screen.dart
    ├── report_detail_screen.dart
    ├── login_screen.dart
    └── profile_screen.dart
```

## Dependencies

Key dependencies:

- `firebase_auth` - User authentication
- `cloud_firestore` - Cloud database
- `firebase_core` - Firebase initialization
- `connectivity_plus` - Network connectivity monitoring

## Troubleshooting

### App won't connect to Firebase

- Verify Firebase configuration files are in place
- Check internet connection
- Review Firebase Console for authentication issues

### Reports not syncing

- Check offline banner status
- Verify internet connectivity
- Ensure Firebase rules allow read/write access

### Build errors

```bash
flutter clean
flutter pub get
flutter pub upgrade
```

## License

This project is private and not licensed for public distribution.
