import 'package:flutter/material.dart';
import 'package:imagefrontend/home.dart';
import 'package:imagefrontend/imageprovider.dart';
import 'package:imagefrontend/login.dart';
import 'package:imagefrontend/savedimage.dart';
import 'package:imagefrontend/signup.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SavedImagesProvider()),
      ],
      child: MyApp(),
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
      home: HomeScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpPage(),
        '/savedimage': (context) => SavedImagesScreen(),
      },
    );
  }
}
