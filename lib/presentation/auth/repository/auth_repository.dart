// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/custom_circular_loader.dart';
import 'package:magueyapp/common/widget/my_toast.dart';
import 'package:magueyapp/presentation/auth/modals/user_model.dart';
import 'package:magueyapp/presentation/home/ui/screen/base_screen.dart';
import 'package:magueyapp/service/firebase_service/firebase_service.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:magueyapp/utils/extensions/string.dart';
import 'package:magueyapp/utils/shared_pref_manager/shared_pref.dart';

class AuthRepository {
  final SharedPrefsManager _sharedPrefsManager;
  AuthRepository(this._sharedPrefsManager);

  Future<bool> createAnAccount(
    BuildContext context, {
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    bool emailValid = _validateEmail(email);
    bool passwordValid = false;
    if (emailValid) {
      passwordValid = _validatePassword(password, type: "Password");
    }

    if (emailValid && passwordValid && password != confirmPassword) {
      MyToast.simple("Password and confirm password must be same");
      return false;
    }

    if (emailValid && passwordValid && password == confirmPassword) {
      bool isSuccess = false;

      await myFirebaseService
          .registerUsingEmailPassword(email: email, password: password)
          .then(
        (user) {
          if (user != null) {
            _sharedPrefsManager.saveOneTimeLogin(user, fromGoogle: false);
            context.pushNamedAndRemoveUntil(BaseScreen.route);
            // _sharedPrefsManager.saveData(
            //     _sharedPrefsManager.IS_USER_LOGIN, true);
            // _sharedPrefsManager.saveData(
            //   _sharedPrefsManager.userEmail,
            //   user.email ?? "no email found",
            // );
            isSuccess = true;
          }
        },
      );
      return isSuccess;
    }

    return false;
  }

  Future<bool> signIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    bool isSuccess = false;
    bool emailValid = _validateEmail(email);
    if (emailValid) {
      await myFirebaseService
          .signInUsingEmailPassword(email: email, password: password)
          .then((user) async {
        if (user != null) {
          _sharedPrefsManager.saveOneTimeLogin(user, fromGoogle: false);
          context.pushNamedAndRemoveUntil(BaseScreen.route);

          isSuccess = true;
        }
      });
    }
    return isSuccess;
  }

  // Future<void> refreshUser(User user) async {
  //     await myFirebaseService.refreshUser(user).then((value) {
  //       if (value != null) {
  //         debugPrint(user.getIdToken().toString());
  //         _sharedPrefsManager.saveData(_sharedPrefsManager.IS_USER_LOGIN, true);
  //       }
  //     });
  // }

  Future<bool> forgotPassword(
    BuildContext context, {
    required String email,
  }) async {
    bool emailValid = _validateEmail(email);
    if (emailValid) return await myFirebaseService.forgotPassword(email: email);
    return false;
  }

  Future<bool> logoutUser() async {
    bool logout = false;
    CustomCircularLoader.showLoaderDialog();
    bool isSocialLogin = _sharedPrefsManager.isUserLogin();

    if (isSocialLogin) {
      logout = await _signOutFromGoogle();
    } else {
      try {
        await myFirebaseService.logoutUser();
        logout = true;
      } catch (e) {
        debugPrint(e.toString());
        logout = false;
      }
    }
    if (logout) await _sharedPrefsManager.logout();
    CustomCircularLoader.dispose();

    return logout;
  }

  Future<bool> _signOutFromGoogle() async {
    bool isSuccess = false;
    try {
      bool isCompleted = await myFirebaseService.signOutWithGoogle();
      if (isCompleted) {
        await _sharedPrefsManager.logout();
        isSuccess = true;
      } else {
        isSuccess = false;
      }
    } catch (e) {
      isSuccess = false;
      MyToast.simple("Operation couldn't be completed!");
    }
    return isSuccess;
  }

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool isSuccess = false;
    CustomCircularLoader.showLoaderDialog();
    // try {
    final UserModel? user = await myFirebaseService.signInWithGoogle();
    if (user != null) {
      await _sharedPrefsManager.saveOneTimeLogin(user, fromGoogle: true);
      context.pushNamedAndRemoveUntil(BaseScreen.route);
      // if (context.mounted) {
      //   context.pushReplacementNamed(BaseScreen.route);
      // }
      isSuccess = true;
    } else {
      isSuccess = false;
      CustomCircularLoader.dispose();
    }
    // } catch (e) {
    //   isSuccess = false;
    //   MyToast.simple("Operation couldn't be completed!");
    // }
    return isSuccess;
  }

  Future<bool> signUpWithGoogle(BuildContext context) async {
    bool isSuccess = false;

    CustomCircularLoader.showLoaderDialog();
    // try {
    final UserModel? user = await myFirebaseService.signUpWithGoogle();

    if (user != null) {
      isSuccess = true;
      await _sharedPrefsManager.saveOneTimeLogin(user, fromGoogle: true);
      if (context.mounted) context.pushNamedAndRemoveUntil(BaseScreen.route);
    } else {
      CustomCircularLoader.dispose();
    }

    return isSuccess;
  }

  bool _validateEmail(String email) {
    if (email.isEmpty) {
      MyToast.simple("Email is required");
      return false;
    }

    if (!email.isAValidEmail()) {
      MyToast.simple("Please enter a valid email");
      return false;
    }

    return true;
  }

  bool _validatePassword(String password, {required String type}) {
    int minimumLength = 8; // minNumsReq = 1, minSpCharsReq = 1, minUpper = 1;
    if (password.isEmpty) {
      MyToast.simple("$type is required");
      return false;
    } else if (!password.containsMinChars(minLength: minimumLength)) {
      MyToast.simple("$type must be $minimumLength characters long");
      return false;
    }
    // else if (!password.containsMinNumbers(min: minNumsReq)) {
    //   MyToast.simple(
    //       "$type must contain atleast $minNumsReq ${minNumsReq == 1 ? "number" : "numbers"}");
    //   return false;
    // }
    // else if (!password.containsMinSpecialChars(min: minSpCharsReq)) {
    //   MyToast.simple(
    //       "$type must contain atleast $minSpCharsReq special ${minSpCharsReq == 1 ? "character" : "characters"}");
    //   return false;
    // } else if (!password.containsUpperCase(min: minUpper)) {
    //   MyToast.simple(
    //       "$type must contain atleast $minSpCharsReq uppercase ${minSpCharsReq == 1 ? "letter" : "letters"}");
    //   return false;
    // }

    return true;
  }
}
