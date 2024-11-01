import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magueyapp/provider/user_provider.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../data/user_controller.dart';
import '../entity/user_entity.dart';
import '../infra/firebase_manager.dart';
import '../ui/features/home/home_screen.dart';
import '../ui/widgets/snackbars.dart';

class LogInSignUpProvider with ChangeNotifier {
  static final LogInSignUpProvider provider = LogInSignUpProvider._internal();

  factory LogInSignUpProvider() {
    return provider;
  }
  LogInSignUpProvider._internal();
  UserProvider userProvider = UserProvider();

  RoundedLoadingButtonController bntControllerSignUp = RoundedLoadingButtonController();
  RoundedLoadingButtonController bntControllerLogIn = RoundedLoadingButtonController();
  RoundedLoadingButtonController bntControllerForgotPassword = RoundedLoadingButtonController();
  RoundedLoadingButtonController bntControllerGoogleSignUp = RoundedLoadingButtonController();
  RoundedLoadingButtonController bntControllerGoogleLogIn = RoundedLoadingButtonController();

  GlobalKey<FormState> formKeyAuthenticationSignUp = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyAuthenticationLogIn = GlobalKey<FormState>();

  GlobalKey<FormState> formKeyAuthenticationResetPassword = GlobalKey<FormState>();

  FirebaseManager firebaseManager = FirebaseManager();
  //TextEditingController signUpName = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();
  TextEditingController signUpConfirmPassword = TextEditingController();

  TextEditingController logInPassword = TextEditingController();
  TextEditingController logInEmail = TextEditingController();

  TextEditingController resetPasswordEmail = TextEditingController();
  bool loading = false;

  bool isCheckedTerms = false;
  void updateIsCheckTerms() {
    print(isCheckedTerms);

    isCheckedTerms = !isCheckedTerms;
  }

  void updateLoading(bool loading) {
    this.loading = loading;
    notifyListeners();
  }

  /* String? validateName(String? value) {
    if (signUpName.text.trim().isEmpty) {
      return "Enter a valid name";
    } else {
      return null;
    }
  }*/

  String? validateEmailSignUp(String? value) {
    String email = signUpEmail.text.trim();
    if (!EmailValidator.validate(email)) {
      return "Enter a valid Email";
    } else {
      return null;
    }
  }

  String? validatePasswordSignUp(String? value) {
    bool regExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$').hasMatch(signUpPassword.text.trim());
    if (!regExp) {
      return "Your password must contain at least 6 characters,\n including upper and lower case letters and numbers.";
    } else {
      return null;
    }
  }

  String? validateConfirmPassword(String? value) {
    if (signUpConfirmPassword.text.trim() != signUpPassword.text.trim()) {
      return "Passwords don't match";
    } else {
      return null;
    }
  }

  String? validateEmailLogIn(String? value) {
    String email = logInEmail.text.trim();
    if (!EmailValidator.validate(email)) {
      return "Enter a valid Email";
    } else {
      return null;
    }
  }

  String? validatePasswordLogIn(String? value) {
    bool regExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$').hasMatch(logInPassword.text.trim());
    if (!regExp) {
      return "Your password must contain at least 6 characters,\n including upper and lower case letters and numbers.";
    } else {
      return null;
    }
  }

  String? validateEmailResetPassword(String? value) {
    String email = resetPasswordEmail.text.trim();
    if (!EmailValidator.validate(email)) {
      return "Enter a valid Email";
    } else {
      return null;
    }
  }

  Future<void> signupUser({required String? userId, required String profile_picture}) async {
    UserEntity new_user = userProvider.createNewUser(
      userId: userId!,
      signUpEmail: signUpEmail.text.trim(),
      profile_picture: profile_picture,
    );
    await UserController().signUpUser(new_user);

    notifyListeners();
  }

  Uint8List? profile_picture;
  Future<void> selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      profile_picture = await img.readAsBytes();
    }
  }

  Future<void> checkConditionsLogInUser(BuildContext context) async {
    //updateLoading(true);
    try {
      final formLogIn = formKeyAuthenticationLogIn.currentState!;
      bool hasInternetAccess = await firebaseManager.hasInternetAccess();

      if (formLogIn.validate()) {
        if (hasInternetAccess == false) {
          ShowSnackBar(context: context).showErrorSnackBar(message: 'Please check your internet connection.', durationInSeconds: 2);
        } else {
          await firebaseManager.loginUser(
            email: logInEmail.text.trim(),
            password: logInPassword.text.trim(),
            context: context,
          );
        }
      }
      // updateLoading(false);
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkConditionsSignUpUser(BuildContext context) async {
    //updateLoading(true);
    final formSignUp = formKeyAuthenticationSignUp.currentState!;
    if (formSignUp.validate()) {
      if (!isCheckedTerms) {
        ShowSnackBar(context: context).showErrorSnackBar(message: 'Please accept the terms and conditions.', durationInSeconds: 2);
      } else {
        await firebaseManager.registerUser(
          email: signUpEmail.text.trim(),
          password: signUpPassword.text.trim(),
          context: context,
          bntController: bntControllerSignUp,
        );
        String profilePicture =
            'https://firebasestorage.googleapis.com/v0/b/spend-ninja-dev.appspot.com/o/no_profile_image.jpg?alt=media&token=228ab9ab-831c-4c3b-8935-f1d32db2366a';
        await signupUser(
          userId: await firebaseManager.getUserCurrentID(),
          profile_picture: profilePicture,
        );
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return const MyHomePage();
          },
        ));
        notifyListeners();
      }
    }
    //updateLoading(false);
  }

  Future<void> resetPassword({required BuildContext context}) async {
    if (formKeyAuthenticationResetPassword.currentState!.validate()) {
      bool hasInternetAccess = await firebaseManager.hasInternetAccess();
      if (hasInternetAccess == false) {
        ShowSnackBar(context: context).showErrorSnackBar(message: 'Please check your internet connection.');
      } else {
        await firebaseManager.resetPassword(email: resetPasswordEmail.text.trim(), context: context);
      }
    }
  }
}
