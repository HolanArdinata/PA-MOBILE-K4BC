import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:laptop_recommendation/model/theme_mode_data.dart';
import 'package:laptop_recommendation/pages/introduction_page.dart';
import 'package:provider/provider.dart';

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
  runApp(
    ChangeNotifierProvider(
        create: (BuildContext context) => ThemeModeData(), child: MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (ctx) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "LAPTOP REVIEW",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrange,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: Provider.of<ThemeModeData>(ctx).themeMode,
        home: IntroductionPage(),
      );
    });
  }
}
