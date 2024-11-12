import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:magueyapp/provider/user_provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../data/user_controller.dart';
import '../design_system/colors.dart';
import '../entity/user_entity.dart';
import '../ui/features/home/home_screen.dart';
import '../ui/widgets/snackbars.dart';

class FirebaseManager {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> getUserCurrentID() async {
    if (firebaseAuth.currentUser != null) {
      return firebaseAuth.currentUser!.uid;
    } else {
      return null;
    }
  }

  Future<void> registerUser({
    required String email,
    required String password,
    required BuildContext context,
    required RoundedLoadingButtonController bntController,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ShowSnackBar(context: context)
            .showErrorSnackBar(message: 'Email already in use');
        bntController.reset();
      }
    }
  }

  Future<User?> loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        UserEntity user =
            await UserController().searchUser(userCredential.user!.uid);
        UserProvider().setCurrentUser(user);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return const MyHomePage();
          },
        ));

        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ShowSnackBar(context: context)
            .showErrorSnackBar(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        ShowSnackBar(context: context).showErrorSnackBar(
            message: 'Wrong password provided for that user.');
      } else if (e.code == 'too-many-requests') {
        ShowSnackBar(context: context).showErrorSnackBar(
            message: 'Too many requests, please try again later.');
      }
    }
    return null;
  }

  Future<bool> hasInternetAccess() async {
    if (kIsWeb) {
      // this package is not working on web
      return true;
    }
    return await InternetConnectionChecker().hasConnection;
  }

  Future signOut({required BuildContext context}) async {
    try {
      return await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      ShowSnackBar(context: context)
          .showErrorSnackBar(message: e.code.toString());
      return null;
    }
  }

  Future resetPassword(
      {required String email, required BuildContext context}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      ShowSnackBar(context: context).showErrorSnackBar(
          message: 'A link was sent to your email to reset your password.',
          color: DSColors.primaryActionState1);
    } on FirebaseAuthException catch (e) {
      ShowSnackBar(context: context)
          .showErrorSnackBar(message: e.code.toString());
    }
  }

  Future<bool> deleteUser(BuildContext context) async {
    if (firebaseAuth.currentUser != null) {
      try {
        await deleteAccount(context);
        await firebaseAuth.currentUser!.delete();

        ShowSnackBar(context: context).showErrorSnackBar(
            message: 'Your account has been successfully deleted.');
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          ShowSnackBar(context: context).showErrorSnackBar(
              message:
                  'Please sign in again to confirm your identity for account deletion.');
        } else {
          ShowSnackBar(context: context).showErrorSnackBar(
              message:
                  'An error occurred while deleting your account: ${e.message}');
        }
        return false;
      }
    } else {
      ShowSnackBar(context: context)
          .showErrorSnackBar(message: 'No user is currently signed in.');
      return false;
    }
  }

  Future<bool> deleteAccount(BuildContext context) async {
    if (firebaseAuth.currentUser != null) {
      final uid = firebaseAuth.currentUser!.uid;

      try {
        await FirebaseFirestore.instance.collection('users').doc(uid).delete();
        await firebaseAuth.currentUser!.delete();

        ShowSnackBar(context: context).showErrorSnackBar(
            message: 'Your account has been successfully deleted.');
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          ShowSnackBar(context: context).showErrorSnackBar(
              message:
                  'Please sign in again to confirm your identity for account deletion.');
        } else {
          ShowSnackBar(context: context).showErrorSnackBar(
              message:
                  'An error occurred while deleting your account: ${e.message}');
        }
        return false;
      } catch (e) {
        ShowSnackBar(context: context).showErrorSnackBar(
            message: 'Failed to delete user data: ${e.toString()}');
        return false;
      }
    } else {
      ShowSnackBar(context: context)
          .showErrorSnackBar(message: 'No user is currently signed in.');
      return false;
    }
  }
}
