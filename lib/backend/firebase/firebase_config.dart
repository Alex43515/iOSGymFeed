import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import '../api_keys.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: ApiKeys.firebaseApiKey,
            authDomain: "gym-feed-official-27tdk3.firebaseapp.com",
            projectId: "gym-feed-official-27tdk3",
            storageBucket: "gym-feed-official-27tdk3.appspot.com",
            messagingSenderId: "756667012146",
            appId: "1:756667012146:web:2c927c6e8f9273207ad82b"));
  } else {
    await Firebase.initializeApp();
  }
}
