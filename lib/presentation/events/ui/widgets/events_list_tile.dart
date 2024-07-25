import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magueyapp/presentation/events/model/event_model.dart';
import 'package:magueyapp/presentation/events/others/hero_tags.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class EventListTile extends StatelessWidget {
  final EventModel event;
  final double topMargin, bottomMargin, height, horizontalMargin;
  final double borderRadius;
  final Function(EventModel) onTap;
  const EventListTile({
    super.key,
    required this.event,
    this.horizontalMargin = 16,
    this.height = 119,
    this.bottomMargin = 16,
    this.topMargin = 0,
    this.borderRadius = 18,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: horizontalMargin.paddingH(context).copyWith(
            top: topMargin.pxV(context),
            bottom: bottomMargin.pxV(context),
          ),
      height: height.pxV(context),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(243, 243, 243, 1),
        borderRadius: BorderRadius.circular(borderRadius.pxV(context)),
      ),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () => onTap(event),
        child: Stack(
          children: [
            Row(
              children: [
                Hero(
                  tag: EventHeroTag.eventImage(event),
                  child: Container(
                    height: height.pxV(context),
                    width: height.pxV(context),
                    decoration: BoxDecoration(
                      color: MyColors.black0D0D0D,
                      borderRadius:
                          BorderRadius.circular(borderRadius.pxV(context)),
                    ),
                    // alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(borderRadius.pxV(context)),
                      child: Image.network(
                        event.imageUrl,
                        fit: BoxFit.cover,
                      ),
                      //  Image.asset(
                      //   "${MyImages.tempFolderPath}/event.png",
                      //   // height: (height - 10).pxV(context),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                ),
                14.hSpace(context),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 40.percentWidth(context),
                      child: TextView(
                        event.name.toUpperCase(),
                        maxLine: 1,
                        overflow: TextOverflow.ellipsis,
                        style: myTextStyle.font_20w800Black,
                      ),
                    ),
                    SizedBox(
                      width: 40.percentWidth(context),
                      child: TextView(
                        event.eventLocation.townName.toUpperCase(),
                        maxLine: 2,
                        overflow: TextOverflow.ellipsis,
                        style: myTextStyle.font_10w600Black,
                      ),
                    ),
                    4.vSpace(context),
                    SizedBox(
                      width: 48.percentWidth(context),
                      child: TextView(
                        event.description.toUpperCase(),
                        maxLine: 3,
                        overflow: TextOverflow.ellipsis,
                        style: myTextStyle.font_10w400Black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding:
                    12.paddingRight(context).copyWith(top: 12.pxV(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextView(
                      event.startTime!,
                      style: myTextStyle.font_10w400Black.copyWith(
                        fontSize: 7.62.pxV(context),
                      ),
                    ),
                    4.vSpace(context),
                    TextView(
                      DateFormat("dd/MM/yyyy").format(event.eventDate!),
                      style: myTextStyle.font_10w400Black.copyWith(
                        fontSize: 7.62.pxV(context),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
