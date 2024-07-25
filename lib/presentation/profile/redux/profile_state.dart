import 'package:magueyapp/presentation/auth/modals/user_model.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';

class ProfileState {
  UserModel? user;
  late ResponseStatus responseStatus;

  ProfileState({
    required this.responseStatus,
    this.user,
  });

  ProfileState.fromState(ProfileState state) {
    user = state.user;
    responseStatus = state.responseStatus;
  }
}
