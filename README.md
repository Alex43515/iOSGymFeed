This is a codemagic test app

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
