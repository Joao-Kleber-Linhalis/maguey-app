// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:magueyapp/presentation/auth/modals/user_model.dart';
import 'package:magueyapp/service/firestore_service/collection_names.dart';
import 'package:magueyapp/utils/extensions/string.dart';
import 'package:magueyapp/utils/shared_pref_manager/shared_pref.dart';

class FirestoreService {
  final SharedPrefsManager sharedPrefsManager;

  const FirestoreService(this.sharedPrefsManager);

  Future<UserModel?> saveUserInfo(User selectedUser) async {
    // The UserEmail will be the docId
    // String docId = sharedPrefsManager.getData(sharedPrefsManager.userId);
    String docId = selectedUser.email!;

    // Creating a custom user model
    UserModel newUser = UserModel(
      createDate: DateTime.now(),
      email: docId,
      userId: selectedUser.uid,
      allowLogin: true,
      userName: docId.split("@").first.capitalizeFirstLetter(),
    );

    String userCol = CollectionNames.userCollection;
    final userDoc = FirebaseFirestore.instance.collection(userCol).doc(docId);

    await userDoc.set(newUser.toJson());

    return newUser;
  }

  Future<UserModel?> getUser(String email) async {
    String userCol = CollectionNames.userCollection;
    final userDoc =
        await FirebaseFirestore.instance.collection(userCol).doc(email).get();

    var userData = userDoc.data();

    if (userData == null) return null;

    return UserModel.fromJson(userData);
  }

  Future<bool> userExists(String email) async {
    String userCol = CollectionNames.userCollection;
    final userDoc =
        await FirebaseFirestore.instance.collection(userCol).doc(email).get();
    var userData = userDoc.data();

    if (userData == null) {
      return false;
    } else {
      return UserModel.fromJson(userData).allowLogin;
    }
  }

  
}
