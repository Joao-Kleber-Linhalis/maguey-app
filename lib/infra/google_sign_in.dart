/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../ui/features/bottom_nav_bar_screen.dart';

class GoogleAuth {
  Future<UserCredential?> signInWithGoogle(
      {required BuildContext context}) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // User canceled the Google Sign-In process
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase using the Google credentials
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                BottomNavBar()), // Change this to your desired next page
      );

      return userCredential;
    } catch (e) {
      // Handle any errors here
      print("Error signing in with Google: $e");
      return null;
    }
  }
}
*/
