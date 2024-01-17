import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import 'package:watch_video/authetication/login_screen.dart';
import 'package:watch_video/widgets/input_text_widget.dart';

import 'authetication_controller.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController userNameTextEditingController = TextEditingController();

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passawordTextEditingController =
      TextEditingController();
  bool showProgressBar = false;

  var authenticationController = AuthenticationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text(
                'Create Account',
                style: GoogleFonts.acme(
                    fontSize: 30,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'to get Started Now!',
                style: GoogleFonts.actor(
                    fontSize: 34,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  authenticationController.captureImageWithCamera();
                },
                child: const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage("assets/user.jpg"),
                  backgroundColor: Colors.black,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: InputTextWidget(
                  textEditingController: userNameTextEditingController,
                  labelString: "Username",
                  iconData: Icons.person_outline,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: InputTextWidget(
                  textEditingController: emailTextEditingController,
                  labelString: "Email",
                  iconData: Icons.email_outlined,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: InputTextWidget(
                  textEditingController: passawordTextEditingController,
                  labelString: "Passaword",
                  iconData: Icons.lock_outline,
                  isObscure: true,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              showProgressBar == false
                  ? Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 38,
                          height: 54,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                showProgressBar = true;
                              });
                            },
                            child: const Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account? ",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(const LoginScreen());
                              },
                              child: const Text(
                                'Login Now',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  : const SimpleCircularProgressBar(
                      progressColors: [
                        Colors.green,
                        Colors.blueAccent,
                        Colors.red,
                        Colors.amber,
                        Colors.purpleAccent,
                      ],
                      animationDuration: 1,
                      backColor: Colors.white38,
                    ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
