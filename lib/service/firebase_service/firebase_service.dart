import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:magueyapp/common/widget/my_toast.dart';
import 'package:magueyapp/presentation/auth/ui/screens/get_started.dart';
import 'package:magueyapp/presentation/auth/modals/user_model.dart';
import 'package:magueyapp/service/firestore_service/firestore_service.dart';
import 'package:magueyapp/utils/connectivity_service/connectivity_service.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';

import '../di.dart';

FirebaseService myFirebaseService = getIt<FirebaseService>();
FirestoreService myFirestoreService = getIt<FirestoreService>();

class FirebaseService {
  FirebaseService();
  Future<UserModel?> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserModel? newUser;
    if (await ConnectivityService.connected()) {
      try {
        // If not then register using firebase auth

        if (await myFirestoreService.userExists(email)) {
          MyToast.simple("User with this email already exists");
          return null;
        }

        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Add email to the firestore collection for future validation
        var user = userCredential.user;

        // await user!.updateDisplayName(name);
        await user!.reload();
        user = auth.currentUser;

        if (user != null && !await myFirestoreService.userExists(email)) {
          newUser = await myFirestoreService.saveUserInfo(user);
        }

        return newUser;

        // } on FirebaseAuthException catch (e) {
        //   // if (e.code == 'weak-password') {
        //   //   MyToast.simple("Please enter a strong passwod");
        //   // } else if (e.code == 'email-already-in-use') {
        //   //   MyToast.simple("This email is alredy in use");
        //   // }
        //   MyToast.simple(e.message.toString());
      } catch (e) {
        debugPrint(e.toString());
        return null;
      }
    }
    return null;
  }

  Future<UserModel?> signUpWithGoogle() async {
    UserModel? userModel;
    if (await ConnectivityService.connected()) {
      try {
        String? clientId;
        if (Platform.isIOS) {
          clientId =
              "584611625768-haphfukfq7lho41s9dehqltfc6nufl11.apps.googleusercontent.com";
        }
        final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: clientId);

        // If the user has signedin with the device, he should signout in order to
        // signin from another device.
        if (await _googleSignIn.isSignedIn()) await _googleSignIn.signOut();

        final GoogleSignInAccount? userAuth = await _googleSignIn.signIn();

        if (userAuth != null) {
          final GoogleSignInAuthentication auth = await userAuth.authentication;

          OAuthCredential oAuth = GoogleAuthProvider.credential(
            accessToken: auth.accessToken,
            idToken: auth.idToken,
          );

          UserCredential credentials =
              await FirebaseAuth.instance.signInWithCredential(oAuth);

          // Find if the email is not already exists
          User? user = credentials.user;
          if (user != null) await user.reload();
          bool userExists = await myFirestoreService.userExists(userAuth.email);
          if (userExists) MyToast.simple("User Already Exists");

          if (user != null && !userExists) {
            userModel = await myFirestoreService.saveUserInfo(user);
          }
        }

        // return null;

        // Add email to the firestore collection for future validation

        return userModel;
      } catch (e) {
        MyToast.simple("Google Signup Failed");
        return null;
      }
    }
    return null;
  }

  Future<UserModel?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserModel? user;

    if (await ConnectivityService.connected()) {
      user = await myFirestoreService.getUser(email);
      if (user != null && user.allowLogin) {
        try {
          await auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
        } catch (e) {
          MyToast.simple("Wrong Credentials");
          debugPrint("$e from firebase sign-in");
          return null;
        }
      } else {
        MyToast.simple("User does not exists");
        return null;
      }
    }
    return user;
  }

  Future<UserModel?> signInWithGoogle() async {
    UserModel? user;

    String? clientId;
    if (Platform.isIOS) {
      clientId =
          "584611625768-haphfukfq7lho41s9dehqltfc6nufl11.apps.googleusercontent.com";
    }
    final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: clientId);

    // If the user has signedin with the device, he should signout in order to
    // signin from another device.
    if (await _googleSignIn.isSignedIn()) await _googleSignIn.signOut();

    // If not then register using firebase GoogleSignin
    final GoogleSignInAccount? userAuth = await _googleSignIn.signIn();

    // Add email to the firestore collection for future validation
    if (userAuth != null) {
      final GoogleSignInAuthentication auth = await userAuth.authentication;

      OAuthCredential oAuth = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );

      UserCredential credential =
          await FirebaseAuth.instance.signInWithCredential(oAuth);

      if (credential.user != null) {
        user = await myFirestoreService.getUser(credential.user!.email!);
      }

      if (user != null && user.allowLogin) {
        return user;
      } else {
        User? authUser = FirebaseAuth.instance.currentUser;
        if (authUser != null) await authUser.delete();

        MyToast.simple("User does not exists");
      }
    }

    return null;
    // } catch (e) {
    //   MyToast.simple("Google Signup Failed");
    //   return null;
    // }
  }

  Future<bool> forgotPassword({
    required String email,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    if (await ConnectivityService.connected()) {
      if (!await myFirestoreService.userExists(email)) {
        MyToast.simple("User does not exist");
        return false;
      }

      try {
        await auth.sendPasswordResetEmail(email: email);
      } on FirebaseAuthException catch (e) {
        MyToast.simple(e.code.toUpperCase());
        return false;
      } catch (e) {
        return false;
      }
    }

    return true;
  }

  Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }

  Future<void> globalLogout() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      } else if (user != null) {
        await logoutUser();
      } else {
        print("No logged");
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

Future<void> logoutUser() async {
  await FirebaseAuth.instance.signOut();
}

Future<void> addUserdataToFirestore(
  String nativeLang,
  String appLang,
  String learningLang,
  String hearAboutUs,
) async {
  Map<String, dynamic> data = {};

  data = {
    'nativeLanguage': nativeLang,
    'appLanguage': appLang,
    'learningLanguage': learningLang,
    'hearAboutUs': hearAboutUs,
  };

  await FirebaseFirestore.instance.collection('userData').add(data);
}

Future<bool> signOutWithGoogle() async {
  bool isSuccess = false;
  try {
    await GoogleSignIn().signOut().then((value) => isSuccess = true);
    return isSuccess;
  } catch (e) {
    MyToast.simple("Operation couldn't be completed");
    return isSuccess;
  }
}
