import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imagefrontend/Provider/imageprovider.dart';
import 'package:imagefrontend/login.dart';
import 'package:imagefrontend/savedimage.dart';
import 'package:imagefrontend/signup.dart';
import 'package:imagefrontend/wrapper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SavedImagesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false,
      title: 'Babynama',
      home: const Wrapper(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpPage(),
        '/savedimage': (context) => SavedImagesScreen(),
      },
    );
  }
}
