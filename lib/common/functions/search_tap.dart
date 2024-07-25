import 'package:magueyapp/presentation/search/view_model/search_route.dart';
import 'package:magueyapp/utils/app_constants/app_context.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';

import '../../presentation/search/ui/screen/search_screen.dart';

onSearchTap(SearchRoute route) {
  SearchTapRoute.route = route;
  GlobalContext.currentContext!.pushNamed(SearchScreen.route);
}
