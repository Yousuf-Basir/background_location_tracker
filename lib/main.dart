import 'package:background_location_tracker/screens/home_page.dart';
import 'package:background_location_tracker/screens/resume_route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/resume-route': (context) => const ResumeRoutePage(),
      },
    );
  }
}
