import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:magueyapp/ui/features/home/home_screen.dart';

import '../data/user_controller.dart';
import '../entity/user_entity.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<UserCredential> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      print(googleUser);
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        UserEntity user = await UserController().searchUser(userCredential.user!.uid);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return const MyHomePage();
          },
        ));
      }

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
      throw Exception('error when login with google');
    }
  }
}
