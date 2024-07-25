import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/auth/modals/user_model.dart';
import 'package:magueyapp/service/di.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';
import 'package:magueyapp/utils/extensions/text_styles.dart';
import 'package:magueyapp/utils/shared_pref_manager/shared_pref.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late UserModel user;
  @override
  void initState() {
    user = getIt<SharedPrefsManager>().getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 10.paddingV(context).copyWith(
            left: 23.pxH(context),
            right: 16.pxH(context),
          ),
      color: MyColors.grey212121,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: "profile",
            child: Container(
              height: 76.pxV(context),
              width: 76.pxV(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset(
                  MyImages.profileDefaultImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          14.hSpace(context),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  user.userName,
                  style: myTextStyle.font_20w800Black.w600
                      .textColor(MyColors.whiteFFFFFF),
                  overflow: TextOverflow.ellipsis,
                ),
                TextView(
                  user.email,
                  style: myTextStyle.font_10w400Black.w500
                      .textColor(MyColors.whiteFFFFFF),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
