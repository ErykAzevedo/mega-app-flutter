# 🔥 Firebase Configuration Guide

## Setup Instructions

To complete the Firebase integration for your Mega App project, follow these steps:

### 1. 📋 Prerequisites
- Firebase project `mega-app-50d1a` should be created
- Firebase CLI installed on your machine
- FlutterFire CLI installed: `dart pub global activate flutterfire_cli`

### 2. 🔧 Configure Firebase for your platforms

Run the following command in your project directory:

```bash
flutterfire configure --project=mega-app-50d1a
```

This will:
- Generate the correct `firebase_options.dart` file
- Configure Firebase for all your target platforms
- Replace the placeholder configurations with real API keys

### 3. 🌐 Web Configuration

After running `flutterfire configure`, you'll need to update the web configuration:

1. Copy the Firebase config from the Firebase Console
2. Replace the content in `web/firebase-config.js` with the actual config
3. The file should look like this:

```javascript
const firebaseConfig = {
  apiKey: "your-actual-api-key",
  authDomain: "mega-app-50d1a.firebaseapp.com",
  projectId: "mega-app-50d1a",
  storageBucket: "mega-app-50d1a.appspot.com",
  messagingSenderId: "your-actual-sender-id",
  appId: "your-actual-app-id"
};

firebase.initializeApp(firebaseConfig);
```

### 4. 📱 Platform-specific Setup

#### Android
- `android/app/google-services.json` will be automatically generated
- Make sure to add this file to your `.gitignore` if it contains sensitive data

#### iOS
- `ios/Runner/GoogleService-Info.plist` will be automatically generated
- The iOS project needs to be configured in Xcode

#### Web
- Configuration is handled through the JavaScript files

### 5. 🗄️ Firestore Database Setup

1. Go to Firebase Console: https://console.firebase.google.com/
2. Select your project `mega-app-50d1a`
3. Navigate to "Firestore Database"
4. Create database in production mode
5. Set up the following security rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow read/write access to units collection
    match /units/{document} {
      allow read, write: if true; // You can add authentication later
    }
  }
}
```

### 6. 🔐 Firebase Storage (Optional)

If you plan to store images or files:

1. Go to Firebase Storage in the console
2. Set up storage bucket
3. Configure storage rules as needed

### 7. 🚀 Features Enabled

Your app now supports:

- ✅ **Data Migration**: Automatically migrates JSON data to Firestore on first run
- ✅ **Real-time Updates**: Can be enhanced to show real-time unit updates
- ✅ **Offline Support**: Firestore provides automatic offline caching
- ✅ **Scalability**: Ready to handle thousands of units
- ✅ **Fallback**: Falls back to JSON if Firebase is unavailable

### 8. 🔄 Data Migration

The app will automatically:
1. Check if Firestore has data
2. If empty, migrate data from `lib/data/units.json` to Firestore
3. Use Firestore as the primary data source going forward
4. Fall back to JSON if Firebase is unavailable

### 9. ⚙️ Environment Variables (Recommended)

For production, consider using environment variables for sensitive Firebase config:

```dart
// Create lib/config/firebase_config.dart
class FirebaseConfig {
  static const String apiKey = String.fromEnvironment('FIREBASE_API_KEY');
  static const String projectId = 'mega-app-50d1a';
  // ... other configs
}
```

### 10. 📊 Next Steps

After configuration, you can:
- Add authentication for unit management
- Implement real-time updates
- Add image storage for units
- Set up push notifications
- Add analytics tracking

### 🔍 Verification

To verify everything is working:

1. Run the app: `flutter run -d chrome`
2. Check browser developer tools for any Firebase errors
3. Verify data migration in Firestore console
4. Test CRUD operations (when implemented)

## 🛠️ Troubleshooting

### Common Issues:

1. **Firebase not initialized**: Make sure `Firebase.initializeApp()` is called before `runApp()`
2. **Web Firebase errors**: Check that Firebase SDKs are loaded in `index.html`
3. **CORS issues**: Make sure your domain is authorized in Firebase project settings
4. **API key issues**: Regenerate API keys if needed from Firebase console

### Getting Help:

- Firebase Documentation: https://firebase.google.com/docs
- FlutterFire Documentation: https://firebase.flutter.dev/
- Firebase Console: https://console.firebase.google.com/

---

Your Mega App is now ready for Firebase! 🚀