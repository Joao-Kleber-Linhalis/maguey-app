import 'package:magueyapp/presentation/events/model/event_model.dart';

class EventHeroTag {
  static String eventImage(EventModel event) {
    return "event-${event.id}-image";
  }
}
