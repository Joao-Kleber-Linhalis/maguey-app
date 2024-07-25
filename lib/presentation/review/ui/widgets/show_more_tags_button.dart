import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/my_buttons/my_text_button.dart';
import 'package:magueyapp/presentation/review/ui/screen/flavor_tags_screen.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:magueyapp/utils/extensions/text_styles.dart';

class ShowMoreTagsButton extends StatelessWidget {
  const ShowMoreTagsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MyTextButton(
      text: "Show more tags",
      onTap: () => context.pushNamed(AddFlavorTagScreen.route),
      style: myTextStyle.font_10w600Black.w700,
      underlineText: false,
      margin: 12.paddingLeft(context).copyWith(
            top: 8.pxV(context),
            bottom: 8.pxV(context),
          ),
      space: 5.pxH(context),
      trailing: const Icon(Icons.arrow_forward_ios, size: 10),
    );
  }
}
