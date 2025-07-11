# iOSGymFeed

This project is a small Flutter application used for testing Codemagic builds.

## Setup

1. **Check Flutter Version**
   ```bash
   flutter --version
   ```
   Ensure that the Flutter SDK is installed and on the expected version.

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```
   This step must run before any iOS dependency install (such as `pod install` on Codemagic).

3. **Run Tests**
   ```bash
   flutter test
   ```

4. **Build for Android**
   ```bash
   flutter build apk --release
   ```
   Or build an app bundle with `flutter build appbundle`.

5. **Build for iOS**
   ```bash
   flutter build ios --release
   ```
   On Codemagic, make sure `flutter pub get` is executed before running `pod install`.

   ## Configuration

Copy `lib/api_keys.example.dart` to `lib/api_keys.dart` and set your secret keys or
provide them via `--dart-define` when building the app. The following variables
are required:

* `GEMINI_API_KEY`
* `IOS_GOOGLE_MAPS_API_KEY`
* `ANDROID_GOOGLE_MAPS_API_KEY`
* `WEB_GOOGLE_MAPS_API_KEY`
* `FIREBASE_API_KEY`

The `lib/api_keys.dart` file is listed in `.gitignore` so your keys remain
private.
