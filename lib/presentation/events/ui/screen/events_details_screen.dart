import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/presentation/events/redux/event_state.dart';
import 'package:magueyapp/presentation/events/ui/widgets/events_details_appbar.dart';
import 'package:magueyapp/presentation/events/ui/widgets/events_image_widget.dart';
import 'package:magueyapp/presentation/events/ui/widgets/events_info_widget.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/description/product_description_container.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class EventsDetailsScreen extends StatelessWidget {
  static const String route = "events_details";
  const EventsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.greyF5F5F5,
      appBar: eventsDetailAppbar(context),
      body: StoreBuilder<EventState>(
        builder: (context, eventStore) => ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            EventsImageWidget(
              image: Image.network(eventStore.state.selectedEvent!.imageUrl),
              // Image.asset(
              //   "${MyImages.tempFolderPath}/event.png",
              //   fit: BoxFit.fill,
              // ),
              event: eventStore.state.selectedEvent!,
            ),
            EventsInfoWidget(event: eventStore.state.selectedEvent!),
            6.vSpace(context),
            DescriptionContainer(
                description: eventStore.state.selectedEvent!.description)
          ],
        ),
      ),
    );
  }
}
