import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insighteye_web/screens/loginsrc.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDEWa1dKFHdr1Br6DjMdGtceNtCfDEoMxo",
      appId: "1:241070395636:web:63b974b84aa0bfcd590ea1",
      messagingSenderId: "241070395636",
      projectId: "insighteye-ccbf7",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insight Eye Web',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginSrc(),
    );
  }
}
