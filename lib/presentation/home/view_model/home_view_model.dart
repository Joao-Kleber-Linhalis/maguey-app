import 'package:magueyapp/base_redux/base_dispatch.dart';
import 'package:magueyapp/data/repositories/api_repository.dart';
import 'package:magueyapp/presentation/home/redux/home_state.dart';
import 'package:magueyapp/utils/enums/apis_enum.dart';
import 'package:magueyapp/utils/enums/status_enum.dart';

class HomeViewModel extends BaseDispatch {
  ApiRepository apiRepository;

  HomeViewModel(this.apiRepository);

  api() {
    apiRepository.fetchData().then((value) {
      value.fold((l) {
        dispatchGet<HomeState>(
          type: APIsEnum.homeApi,
          status: ResponseStatus.error,
          error: l.message,
        );
      }, (r) {
        dispatchGet<HomeState>(
          type: APIsEnum.homeApi,
          status: ResponseStatus.success,
          payload: r,
        );
      });
    });
  }
}
