import 'package:flutter/material.dart';

import '../../../custom_app_bar.dart';
import '../../../entity/event_entity.dart';
import '../../../theme/my_colors.dart';
import '../../../theme/text_styling.dart';
import 'add_a_event.dart';

class EventsScreen extends StatelessWidget {
  final EventEntity event;
  const EventsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black2B2B2B,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Text(
                event.name,
                style: TextStyleCustom().font_16w600Black.copyWith(
                      color: MyColors.greenE3FF0A,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  event.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                children: [
                  Text(
                    'FESTIVALS',
                    style: TextStyleCustom().font_12w500.copyWith(
                          color: MyColors.orangeFD5944,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    '|',
                    style: TextStyleCustom().font_12w500.copyWith(
                          color: MyColors.orangeFD5944,
                        ),
                  ),
                  Text(
                    event.state,
                    style: TextStyleCustom().font_12w500.copyWith(
                          color: MyColors.orangeFD5944,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    '|',
                    style: TextStyleCustom().font_12w500.copyWith(
                          color: MyColors.orangeFD5944,
                        ),
                  ),
                  Text(
                    event.townName,
                    style: TextStyleCustom().font_12w500.copyWith(
                          color: MyColors.orangeFD5944,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                event.description,
                style: TextStyleCustom().font_14w400.copyWith(
                      color: MyColors.yellowE2D7C1,
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 15,
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    'Add to Calendar',
                    style: TextStyleCustom().font_14w400.copyWith(
                          color: MyColors.brown97805F,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                  Text(
                    'Share Event',
                    style: TextStyleCustom().font_14w400.copyWith(
                          color: MyColors.brown97805F,
                          decoration: TextDecoration.underline,
                        ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const SuggestEvent(),
                        ),
                      );
                    },
                    child: Text(
                      'Suggest an Event',
                      style: TextStyleCustom().font_14w400.copyWith(
                            color: MyColors.brown97805F,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
