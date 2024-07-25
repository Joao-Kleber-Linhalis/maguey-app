import 'dart:io';
import 'package:flutter/material.dart';
import 'package:magueyapp/service/di.dart';
import 'package:magueyapp/app/app_view.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebaseApp();
  await setupDI();
  runApp(const MyApp());
}

Future<void> initializeFirebaseApp() async {
  if (Platform.isAndroid) {
    await Firebase.initializeApp(options: _androidOptions);
  } else if (Platform.isIOS) {
    await Firebase.initializeApp(options: _iosOptions);
  } else {
    await Firebase.initializeApp();
  }
}

FirebaseOptions _iosOptions = const FirebaseOptions(
  apiKey: "AIzaSyBN-uiQXRxc0nups5ufXfQflhFRz7x0Cfo",
  appId: "1:584611625768:ios:51eb1c29a96d134c326e1d",
  messagingSenderId: "584611625768",
  projectId: "maguey-all-day-app",
);

FirebaseOptions _androidOptions = const FirebaseOptions(
  apiKey: "AIzaSyBxgzG_QH5pkgcO9rLU5LAcUaLUkoshT_U",
  appId: "1:584611625768:android:d8713a514ec8ac61326e1d",
  messagingSenderId: "584611625768",
  projectId: "maguey-all-day-app",
);
