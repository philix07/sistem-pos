import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kerja_praktek/firebase_options.dart';
import 'package:kerja_praktek/frontend/presentation/home/dashboard_page.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: DashboardPage(),
    );
  }
}
