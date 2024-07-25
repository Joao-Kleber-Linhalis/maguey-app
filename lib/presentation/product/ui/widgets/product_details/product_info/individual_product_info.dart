import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/my_toast.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/product/model/product_info_model.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductInfoWidget extends StatelessWidget {
  final ProductInfo info;
  const ProductInfoWidget({
    super.key,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 12.paddingBottom(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            info.key,
            style: myTextStyle.font_12w600Black,
          ),
          info.key != "Website"
              ? TextView(
                  info.value,
                  style: myTextStyle.font_12w500Black.w400,
                  width: 60.percentWidth(context),
                  textAlign: TextAlign.end,
                )
              : InkWell(
                  onTap: () async {
                    final url = info.value.substring(0, info.value.length - 1);
                    if (!await launchUrl(Uri.parse(url))) {
                      MyToast.simple("Could not launch $url");
                    }
                  },
                  child: TextView(
                    info.value,
                    style: myTextStyle.font_12w500Black.w400
                        .copyWith(color: Colors.blue[800]),
                    width: 60.percentWidth(context),
                    textAlign: TextAlign.end,
                  ),
                )
        ],
      ),
    );
  }
}
