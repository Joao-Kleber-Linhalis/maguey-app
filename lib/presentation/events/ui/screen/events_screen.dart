import 'package:flutter/material.dart';
import 'package:magueyapp/theme/my_colors.dart';
import '../../../../theme/text_styling.dart';
import '../../../widgets/custom_app_bar.dart';
import 'add_a_event.dart';

final textStyles = TextStyleCustom();

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black2B2B2B,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Text(
                'Mezcal & Mushrooms – Spirits & Rituals',
                style: textStyles.font_16w600Black.copyWith(
                  color: MyColors.greenE3FF0A,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/temp/agua_magica.jpeg',
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                children: [
                  Text(
                    'FESTIVALS',
                    style: textStyles.font_12w500.copyWith(
                      color: MyColors.orangeFD5944,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '|',
                    style: textStyles.font_12w500.copyWith(
                      color: MyColors.orangeFD5944,
                    ),
                  ),
                  Text(
                    'CALIFORNIA',
                    style: textStyles.font_12w500.copyWith(
                      color: MyColors.orangeFD5944,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '|',
                    style: textStyles.font_12w500.copyWith(
                      color: MyColors.orangeFD5944,
                    ),
                  ),
                  Text(
                    'OJAI',
                    style: textStyles.font_12w500.copyWith(
                      color: MyColors.orangeFD5944,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'The Mezcal and Magic Mushrooms Festival is a vibrant outdoor celebration that brings together the rich cultural heritage of mezcal with the mystical allure of magic mushrooms. Set against a backdrop of scenic landscapes, the festival features artisanal mezcal tastings, live music, and traditional dance performances.',
                style: textStyles.font_14w400.copyWith(
                  color: MyColors.yellowE2D7C1,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Attendees can explore the fascinating world of fungi through educational workshops and guided mushroom foraging tours. With a focus on community and sustainability, this unique event offers an immersive experience that honors ancient traditions while fostering a deep connection to nature.',
                style: textStyles.font_14w400.copyWith(
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
                    style: textStyles.font_14w400.copyWith(
                      color: MyColors.brown97805F,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'Share Event',
                    style: textStyles.font_14w400.copyWith(
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
                              const AddEventPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Create New Event',
                      style: textStyles.font_14w400.copyWith(
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
