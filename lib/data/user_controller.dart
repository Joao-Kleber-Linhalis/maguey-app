import '../entity/user_entity.dart';
import '../infra/firebase_controller.dart';
import 'name_collections.dart';

class UserController {
  final _firebase = FirebaseController();
  final _collection = NameCollections.userCollection;

  Future<bool> signUpUser(UserEntity user) async {
    try {
      await _firebase.updateData(
        data: user,
        id: user.id,
        collection: _collection,
      );
      return true;
    } catch (e, stackTrace) {
      return Future.error("Error while signing up user ${e.toString()}{", stackTrace);
    }
  }

  Future<void> updateUser(UserEntity user) async {
    try {
      await _firebase.updateData(
        collection: _collection,
        id: user.id,
        data: user,
      );
    } catch (e, stackTrace) {
      return Future.error("Error while updating user ${e.toString()}{", stackTrace);
    }
  }

  Future<UserEntity> searchUser(String userId) async {
    try {
      final dado = await _firebase.searchData(
        collection: _collection,
        id: userId,
      );
      final user = UserEntity.fromJson(dado);
      return user;
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }

  Future<List<UserEntity>> searchUserWithCondition(String cond, String condName) async {
    List<UserEntity> retorno = [];
    try {
      final dado = await _firebase.searchDataWithCondition(collection: _collection, cond: cond, condName: condName);
      dado.forEach((element) {
        retorno.add(UserEntity.fromJson(element));
      });

      return retorno;
    } catch (e, stackTrace) {
      return Future.error(e.toString(), stackTrace);
    }
  }
}
