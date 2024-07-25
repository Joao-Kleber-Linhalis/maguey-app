import 'package:magueyapp/presentation/auth/modals/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsManager {
  final SharedPreferences _sharedPreferences;

  SharedPrefsManager(this._sharedPreferences);

  Future<void> saveListOfString(String key, List<String> list) async {
    await _sharedPreferences.setStringList(key, list);
  }

  List<String> getListOfString(String key) {
    return _sharedPreferences.getStringList(key) ?? [];
  }

  // Save data to shared preferences
  Future<void> saveDataToStorage(String key, dynamic value) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    }
    // Add more cases for other data types if needed
  }

  Future<void> saveOneTimeLogin(UserModel user,
      {required bool fromGoogle}) async {
    await saveDataToStorage(IS_USER_LOGIN, true);
    await saveDataToStorage(IS_SOCIAL_LOGIN, fromGoogle);
    await saveDataToStorage(userEmail, user.email);
    await saveDataToStorage(userId, user.userId);
    await saveDataToStorage(userName, user.userName);
    await saveDataToStorage(createDate, user.createDate.toString());
  }

  Future<void> logout() async {
    await _sharedPreferences.clear();
  }

  // Get data from shared preferences
  dynamic getData(String key) {
    return _sharedPreferences.get(key);
  }

  bool isUserLogin() {
    return _sharedPreferences.getBool(IS_USER_LOGIN) ?? false;
  }

  String? getUserEmail() {
    bool isLogin = _sharedPreferences.getBool(IS_USER_LOGIN) ?? false;
    String? email;
    if (isLogin) {
      email = _sharedPreferences.getString(userEmail);
    }

    return email;
  }

  UserModel getUser() {
    String name = _sharedPreferences.getString(userName) ?? "";
    String email = _sharedPreferences.getString(userEmail) ?? "";
    String date = _sharedPreferences.getString(createDate) ?? "";

    return UserModel(
      email: email,
      userId: email,
      allowLogin: true,
      userName: name,
      createDate: DateTime.parse(date),
    );
  }

  final String tokenKey = 'token';
  final String IS_USER_LOGIN = 'isUserLogin';
  final String IS_SOCIAL_LOGIN = 'isSocialLogin';
  // final String THEME_DARK = 'isDarkTheme';
  final String userEmail = 'email';
  final String userId = 'user_id';
  final String userName = 'user_name';
  final String createDate = 'create_date';

  // static String isUserPremium = 'isUserPremium';
  // final String languageCode = 'languageCode';
  // final String countryCode = 'countryCode';
}
