import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/utils/app_route.dart';
import 'package:provider/provider.dart';

import '../../../entity/event_entity.dart';
import '../../../provider/dashboard_provider.dart';
import 'events_screen.dart';

class EventsList extends StatefulWidget {
  const EventsList({super.key});

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  late DashboardProvider dashboardProvider;
  List<EventEntity> events = [];
  List<EventEntity> filteredEvents = [];

  TextEditingController eventTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dashboardProvider = Provider.of<DashboardProvider>(context, listen: false);
    events = dashboardProvider.events;
    filteredEvents = events;

    // Adding the listener
    eventTitleController.addListener(_filterEvents);
  }

  @override
  void dispose() {
    eventTitleController.removeListener(_filterEvents);
    eventTitleController.dispose();
    super.dispose();
  }

  void _filterEvents() {
    String searchTerm = eventTitleController.text.toLowerCase();
    setState(() {
      filteredEvents = events.where((event) {
        return event.name.toLowerCase().contains(searchTerm);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Search',
              filled: true,
              fillColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              hintStyle: const TextStyle(color: Colors.white),
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
            controller: eventTitleController,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredEvents.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildListItem(
                title: filteredEvents[index].name,
                onTap: () {
                  AppRoutes.push(context, EventsScreen(event: filteredEvents[index]));
                },
                heightOfScreen: MediaQuery.of(context).size.height,
                widthOfScreen: MediaQuery.of(context).size.width,
                imageUrl: filteredEvents[index].imageUrl,
              );
            },
          ),
        ),
      ],
    );
  }
}

Widget _buildListItem({
  required String title,
  required String imageUrl,
  required VoidCallback onTap,
  required double heightOfScreen,
  required double widthOfScreen,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: heightOfScreen * 0.026667, vertical: widthOfScreen * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            //Title on right
            title,
            style: TextStyle(
              fontFamily: 'CircularAirPro',
              fontSize: heightOfScreen * 0.02,
              height: heightOfScreen * 0.001750,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFE3FF0A),
            ),
          ),
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
