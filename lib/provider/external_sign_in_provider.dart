import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:magueyapp/data/user_controller.dart';
import 'package:magueyapp/provider/user_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class ExternalSignInProvider extends ChangeNotifier {
  static final ExternalSignInProvider provider =
      ExternalSignInProvider._internal();

  factory ExternalSignInProvider() {
    return provider;
  }

  ExternalSignInProvider._internal() {
    print("Google provider");
  }
  final UserController _userController = UserController();
  final UserProvider _userprovider = UserProvider();

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;
      if (user != null) {
        if (!await _userController.userExist(user.uid)) {
          String profilePicture =
              'https://firebasestorage.googleapis.com/v0/b/spend-ninja-dev.appspot.com/o/no_profile_image.jpg?alt=media&token=228ab9ab-831c-4c3b-8935-f1d32db2366a';
          _userprovider.createNewUser(
            userId: user.uid,
            signUpEmail: user.email!,
            profilePicture: profilePicture,
          );
        }
      }

      return userCredential;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<UserCredential?> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ]);

      final aAuthCredential = OAuthProvider('apple.com').credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(aAuthCredential);

      final user = userCredential.user;
      if (user != null) {
        if (!await _userController.userExist(user.uid)) {
          String profilePicture =
              'https://firebasestorage.googleapis.com/v0/b/spend-ninja-dev.appspot.com/o/no_profile_image.jpg?alt=media&token=228ab9ab-831c-4c3b-8935-f1d32db2366a';
          _userprovider.createNewUser(
            userId: user.uid,
            signUpEmail: user.email!,
            profilePicture: profilePicture,
          );
        }
      }

      return userCredential;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

}
