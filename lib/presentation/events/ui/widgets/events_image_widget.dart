import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/events/model/event_model.dart';
import 'package:magueyapp/presentation/events/others/hero_tags.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class EventsImageWidget extends StatelessWidget {
  final Widget image;
  final double topMargin;
  final EventModel event;
  const EventsImageWidget({
    super.key,
    required this.image,
    this.topMargin = 16,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.whiteFFFFFF,
      height: 173.pxV(context),
      padding: topMargin.paddingTop(context),
      child: Container(
        height: 173.pxV(context),
        margin: 16.paddingH(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.pxH(context)),
          color: MyColors.black0D0D0D,
        ),
        child: Hero(
          tag: EventHeroTag.eventImage(event),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.pxH(context)),
            child: image,
          ),
        ),
      ),
    );
  }
}
