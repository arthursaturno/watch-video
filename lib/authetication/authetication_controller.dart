// authetication_controller.dart

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:watch_video/authetication/login_screen.dart';
import 'package:watch_video/global.dart';
import 'package:watch_video/home/home.dart';
// ignore: library_prefixes
import 'user.dart' as userModel;

class AuthenticationController extends GetxController {
  static AuthenticationController instanceAuth = Get.find();

  late Rx<User?> _currentUser;
  late Rx<File?> _pickedFile;
  File? get profileImage => _pickedFile.value;

  void chooseImageFromGallery() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImageFile != null) {
      Get.snackbar("Profile Image",
          "You have successfully selected your profile picture");
    }

    _pickedFile = Rx<File?>(File(pickedImageFile!.path));
  }

  void captureImageWithCamera() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImageFile != null) {
      Get.snackbar("Profile Image",
          "You have successfully captured your profile picture with your phone's camera");
    }

    _pickedFile = Rx<File?>(File(pickedImageFile!.path));
  }

  void createAccountForNewUser(
    File imageFile,
    String userName,
    String userEmail,
    String userPassword,
  ) async {
    try {
      //Create user
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      //Save image
      String imageDownloadUrl = await uploadImageToFirebase(imageFile);

      //Save firestore database
      userModel.User user = userModel.User(
        uid: credential.user!.uid,
        name: userName,
        email: userEmail,
        image: imageDownloadUrl,
      );

      await FirebaseFirestore.instance
          .collection("users")
          .doc(credential.user!.uid)
          .set(user.toJson());

      Get.snackbar(
        "Account Created",
        "Congratulations, your account has been created",
      );

      showProgressBar = false;
    } catch (error) {
      Get.snackbar("Account Creation Unsucessful",
          "Error ocurred while creating account. Try Again.");
      showProgressBar = false;
      Get.to(const LoginScreen());
    }
  }

  Future<String> uploadImageToFirebase(File? file) async {
    if (file != null) {
      String fileName = file.path.split('/').last;
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(file);
      TaskSnapshot taskSnapshot = await uploadTask;
      String image = await taskSnapshot.ref.getDownloadURL();
      return image;
    } else {
      return Future.value('AppConfig.DEFAULT_GROUP');
    }
  }

  void loginUser(String userEmail, String userPassword) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      Get.snackbar("Logged-in", "you're logged-in sucessful");
      showProgressBar = false;
    } catch (error) {
      Get.snackbar(
          "Login Unsucessful", "Error ocurred during signin authentication.");
      showProgressBar = false;
      Get.to(const LoginScreen());
    }
  }

  goToScreen(User? currentUser) {
    if (currentUser == null) {
      Get.offAll(const LoginScreen());
    } else {
      Get.offAll(const HomeScreen());
    }
  }

  @override
  void onReady() {
    super.onReady();

    _currentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    _currentUser.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_currentUser, goToScreen);
  }
}
