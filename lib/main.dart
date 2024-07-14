import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAduTiSSkoL-b45z4NytofHFSjjhlTKZb4",
            authDomain: "stylebyte1.firebaseapp.com",
            projectId: "stylebyte1",
            storageBucket: "stylebyte1.appspot.com",
            messagingSenderId: "831869856022",
            appId: "1:831869856022:web:c0974e804832f9b1248837",
            measurementId: "G-TY0Z9LHLVF"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Palette App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomeScreen(),
    );
  }
}
