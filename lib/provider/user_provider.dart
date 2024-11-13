import 'dart:io';
import 'dart:typed_data';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magueyapp/data/name_collections.dart';
import 'package:magueyapp/infra/firebase_controller.dart';

import '../data/user_controller.dart';
import '../design_system/Text/ds_text.dart';
import '../design_system/colors.dart';
import '../entity/user_entity.dart';
import '../infra/firebase_manager.dart';
import '../infra/save_image.dart';
import '../ui/widgets/snackbars.dart';
import 'dashboard_provider.dart';

class UserProvider with ChangeNotifier {
  static final UserProvider provider = UserProvider._internal();

  factory UserProvider() {
    return provider;
  }
  UserProvider._internal();
  GlobalKey<FormState> formKeyAuthenticationUpdatePassword =
      GlobalKey<FormState>();
  DashboardProvider dashboardProvider = DashboardProvider();
  UserController userController = UserController();
  String profilePicturePath = '';
  UserEntity currentUser = UserEntity.empty();
  final FirebaseController _firebase = FirebaseController();
  setCurrentUser(UserEntity user) {
    currentUser = user;
    notifyListeners();
  }

  Future<UserEntity> createNewUser({
    required String userId,
    required String signUpEmail,
    required String profilePicture,
  }) async {
    final newUser = UserEntity(
        id: userId,
        //name: signUpName,
        email: signUpEmail,
        profilePicture: profilePicture,
        createdAt: DateTime.now(),
        favoriteProducts: [],
        favoriteEvents: []);
    await _firebase.registerData(
        data: newUser, collection: NameCollections.userCollection);
    return newUser;
  }

  String getCurrentUserProfilePicture() {
    profilePicturePath = dashboardProvider.currentUser.profilePicture;
    return profilePicturePath;
  }

  void goToProfileScreen(
      {required BuildContext context, required UserEntity user}) {}

  final ImagePicker picker = ImagePicker();
  File? photoFile;

  void setPhotoFileNull() {
    photoFile = null;
    notifyListeners();
  }

  Future imgFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photoFile = File(pickedFile.path);
      notifyListeners();
    } else {}
  }

  Future imgFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      photoFile = File(pickedFile.path);
      notifyListeners();
    } else {
      debugPrint('No image selected.');
    }
  }

  Future<void> showImagePicker(context) async {
    await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const DS18DarkPurpleText(
                      text: 'Gallery',
                    ),
                    onTap: () async {
                      Navigator.of(context).pop();
                      await imgFromGallery();
                      await updateUserImage(context: context);
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const DS18DarkPurpleText(
                    text: 'Camera',
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await imgFromCamera();
                    await updateUserImage(context: context);
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<Uint8List> convertFileToUint8List(File file) async {
    List<int> bytes = await file.readAsBytes();
    return Uint8List.fromList(bytes);
  }

  Future<String> updateUserImage({required BuildContext context}) async {
    try {
      String? userId = await FirebaseManager().getUserCurrentID();
      if (userId == null) {
        throw Exception('User not connected');
      }
      String profilePicture = await SaveImage(
              image: await convertFileToUint8List(photoFile!),
              path: 'profile_images',
              id: userId)
          .saveAndGetUrl();
      UserEntity newUser = await createNewUser(
          userId: dashboardProvider.currentUser.id,
          //signUpName: dashboardProvider.currentUser.name,
          signUpEmail: dashboardProvider.currentUser.email,
          profilePicture: profilePicture);
      await userController.updateUser(newUser);
      photoFile = null;
      ShowSnackBar(context: context).showErrorSnackBar(
        message: 'Image successfully updated.',
        color: DSColors.primaryActionState1,
      );

      notifyListeners();
      return profilePicture;
    } catch (e) {
      debugPrint(e.toString());
    }
    return '';
  }

  TextEditingController updateName = TextEditingController();
  TextEditingController updateEmail = TextEditingController();
  TextEditingController updatePassword = TextEditingController();
  TextEditingController currentPassword = TextEditingController();
  TextEditingController updateConfirmPassword = TextEditingController();

  void initializeFields({required UserEntity user}) {
    //updateName.text = user.name;
    updateEmail.text = user.email;
    updatePassword.text = '';
    updateConfirmPassword.text = '';
  }

  String? validateName(String? value) {
    if (updateName.text.trim().isEmpty) {
      return "Enter a valid name";
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    String email = updateEmail.text.trim();
    if (!EmailValidator.validate(email)) {
      return "Enter a valid Email";
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    bool regExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$')
        .hasMatch(updatePassword.text.trim());
    if (!regExp) {
      return "Your password must contain at least 6 characters,\n including upper and lower case letters and numbers.";
    } else {
      return null;
    }
  }

  String? validateConfirmPassword(String? value) {
    if (updateConfirmPassword.text.trim() != updatePassword.text.trim()) {
      return "Passwords don't match";
    } else {
      return null;
    }
  }

  String? validateEmailUpdatePassword(String? value) {
    String email = updatePasswordEmail.text.trim();
    if (!EmailValidator.validate(email)) {
      return "Enter a valid Email";
    } else {
      return null;
    }
  }

  final updatePasswordEmail = TextEditingController();
  final firebaseManager = FirebaseManager();

  Future<void> resetPassword({
    required BuildContext context,
    required String newEmail,
  }) async {
    bool hasInternetAccess = await firebaseManager.hasInternetAccess();
    if (hasInternetAccess == false) {
      ShowSnackBar(context: context)
          .showErrorSnackBar(message: 'Please check your internet connection.');
    } else {
      await firebaseManager.resetPassword(
        email: updatePasswordEmail.text.trim().isEmpty
            ? newEmail
            : updatePasswordEmail.text.trim(),
        context: context,
      );
      ShowSnackBar(context: context).showErrorSnackBar(
          message: 'A link was sent to your email to reset your password.',
          color: DSColors.primaryActionState1);
    }
  }

  Future<void> updateUserEmailAndName({required BuildContext context}) async {
    if (updateEmail.text.trim() == dashboardProvider.currentUser.email) {
      ShowSnackBar(context: context).showErrorSnackBar(
        message: 'No Data updated.',
        color: DSColors.primaryActionState1,
      );
      Navigator.of(context).pop();
      return;
    } else {
      UserEntity newUser = await createNewUser(
          userId: dashboardProvider.currentUser.id,
          // signUpName: updateName.text.trim(),
          signUpEmail: updateEmail.text.trim(),
          profilePicture: photoFile == null
              ? dashboardProvider.currentUser.profilePicture
              : await updateUserImage(context: context));
      userController.updateUser(newUser);
      ShowSnackBar(context: context).showErrorSnackBar(
        message: 'Data successfully updated.',
        color: DSColors.primaryActionState1,
      );

      return;
    }
  }
}
