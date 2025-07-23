import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:luxury_motors/login.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  CloudinaryContext.cloudinary = Cloudinary.fromCloudName(cloudName: 'dchmqjrum');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontStyle: FontStyle.italic),
          bodyMedium: TextStyle(fontStyle: FontStyle.italic),
          titleLarge: TextStyle(fontStyle: FontStyle.italic),
          titleMedium: TextStyle(fontStyle: FontStyle.italic),
          labelLarge: TextStyle(fontStyle: FontStyle.italic),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home:  LoginPage(),
    );
  }
}
