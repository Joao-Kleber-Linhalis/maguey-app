import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:magueyapp/data/name_collections.dart';
import 'package:magueyapp/data/user_controller.dart';
import 'package:magueyapp/entity/user_entity.dart';
import 'package:magueyapp/infra/firebase_controller.dart';
import 'package:magueyapp/provider/user_provider.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final FirebaseController _firebase = FirebaseController();
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
}
