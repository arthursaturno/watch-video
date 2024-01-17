import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:watch_video/authetication/authetication_controller.dart';

import 'authetication/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value) {
    Get.put(AuthenticationController());
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Watch Video',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
