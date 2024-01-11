import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Text(
              'Watch Video',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
            const Icon(
              Icons.video_call_sharp,
              size: 36,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Welcome',
              style: GoogleFonts.acme(
                  fontSize: 30,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Glad to see you!',
              style: GoogleFonts.actor(
                  fontSize: 34,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    ));
  }
}