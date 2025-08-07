# ARound-You
This repo is regarding my university minor project.

---

# ARound You - Flutter AR Project

A Flutter application that combines Augmented Reality (AR) with social discovery features, allowing users to place AR memories and discover people around them.

## Features

- **AR Memory Placement**: Place 3D objects in the real world using AR Core
- **Authentication**: Firebase Auth for user registration and login
- **User Profiles**: View user information and achievements
- **Social Discovery**: Placeholder for nearby user discovery (100m radius)
- **Modern UI**: Dark theme with purple accent colors

## Prerequisites

- Flutter SDK (latest stable version)
- Android Studio / VS Code
- Physical Android device with AR Core support (AR features don't work on emulators)
- Firebase project

## Setup Instructions

### 1. Clone and Setup

```bash
git clone <repository-url>
cd around_you
flutter pub get
```

### 2. Firebase Setup

1. **Create a Firebase Project**:
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Create a new project
   - Enable Authentication (Email/Password)
   - Enable Firestore Database

2. **Configure Firebase for Android**:
   - In Firebase Console, go to Project Settings
   - Add Android app with package name: `com.example.around_you`
   - Download `google-services.json` and place it in `android/app/`

3. **Configure Firebase for Flutter**:
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

### 3. Android Configuration (Required for AR)

The following configurations have already been applied:

#### AndroidManifest.xml
- Camera permission added
- AR hardware feature requirement added

#### build.gradle.kts
- Minimum SDK version set to 24
- AR Sceneform plugin added

### 4. Run the App

```bash
flutter run
```

**Important**: AR features only work on physical Android devices with AR Core support. Emulators will not work for AR functionality.

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── auth/
│   └── auth_gate.dart       # Authentication state management
└── screens/
    ├── auth_screen.dart      # Login/Signup screen
    ├── home_screen.dart      # Main navigation
    ├── ar_memory_view.dart   # AR functionality
    ├── social_discovery_view.dart # Social features
    └── profile_view.dart     # User profile
```

## Dependencies

- `firebase_core`: Firebase initialization
- `firebase_auth`: User authentication
- `cloud_firestore`: Database operations
- `flutter_riverpod`: State management
- `ar_flutter_plugin`: AR functionality
- `vector_math`: 3D math operations

## AR Features

The AR functionality is currently set up with a basic AR view. To enhance it:

1. **Add 3D Models**: Replace the placeholder URL with your own .glb models
2. **Implement Object Placement**: Complete the AR interaction logic
3. **Add Memory Storage**: Connect AR objects to user memories in Firestore

## Development Notes

- The app uses a dark theme with purple accents
- Authentication is handled through Firebase Auth
- User data is stored in Firestore
- AR functionality requires physical device testing
- Social discovery features are placeholder implementations

## Troubleshooting

### AR Not Working
- Ensure you're using a physical Android device
- Check that AR Core is installed and up to date
- Verify camera permissions are granted

### Firebase Issues
- Ensure `google-services.json` is in the correct location
- Check Firebase project configuration
- Verify Authentication and Firestore are enabled

### Build Issues
- Run `flutter clean` and `flutter pub get`
- Check Android SDK version (minimum 24)
- Ensure all dependencies are compatible

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on a physical device
5. Submit a pull request

## License

This project is licensed under the MIT License.
>>>>>>> dffb3c7 (First commit UI and auth made)
