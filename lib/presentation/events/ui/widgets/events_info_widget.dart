import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/events/model/event_model.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/product_details/titled_text_widget.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class EventsInfoWidget extends StatelessWidget {
  final EventModel event;
  final int maxLines;
  final double topMargin;
  const EventsInfoWidget({
    super.key,
    required this.event,
    this.maxLines = 3,
    this.topMargin = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.whiteFFFFFF,
      padding: 20.paddingH(context).copyWith(top: topMargin.pxV(context)),
      child: Column(
        children: [
          _row(
            context,
            [
              _showVal("Name", event.name),
              _showVal("Area/Town", event.eventLocation.townName),
            ],
          ),
          _row(
            context,
            [
              if (event.startTime != null)
                _showVal("Start Time", event.startTime!),
              if (event.endTime != null) _showVal("End Time", event.endTime!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(
    BuildContext context,
    List<Widget> children, [
    double btmMargin = 25,
  ]) {
    return Padding(
      padding: btmMargin.paddingBottom(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _showVal(String title, String val) {
    return TitledTextContainer(
      title: title,
      value: val,
      percentWidth: 40,
      maxLines: maxLines,
    );
  }
}
