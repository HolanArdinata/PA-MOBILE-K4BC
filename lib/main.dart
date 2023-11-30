import 'package:laptop_recommendation/auth_gate.dart';
import 'package:laptop_recommendation/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:laptop_recommendation/pages/introduction_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyC_5Kn0-dVLVBVk5eKAuV1_tfS6rYxIpxQ',
      appId: '1:578402082331:android:849de4e8467f078de5e2be',
      messagingSenderId: '578402082331',
      projectId: 'laptoprekomendasi-2dde6',
    ),
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey,
        // scaffoldBackgroundColor: Colors.deepOrange.shade100,
        // primarySwatch: Colors.deepOrange,
      ),
      home: IntroductionPage(),
    );
  }
}
