import 'package:magueyapp/presentation/auth/modals/user_model.dart';
import 'package:magueyapp/service/di.dart';
import 'package:magueyapp/service/firestore_service/firestore_service.dart';
import 'package:magueyapp/utils/shared_pref_manager/shared_pref.dart';

class ProfileViewModel {
  final FirestoreService _firestoreService = getIt<FirestoreService>();
  final SharedPrefsManager _pref = getIt<SharedPrefsManager>();
  Future getUser() async {
    String? email = _pref.getUserEmail();
    UserModel? user;
    if (email != null) {
      user = await _firestoreService.getUser(email);
    }

    print(user);
  }
}
