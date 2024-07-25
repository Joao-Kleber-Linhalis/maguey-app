import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/my_buttons/my_elevated_button.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/titled_app_bar.dart';
import 'package:magueyapp/presentation/filters/ui/widgets/custom_filter_widget.dart';
import 'package:magueyapp/presentation/filters/view_model/filters_list.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class FiltersScreen extends StatefulWidget {
  static const String route = "filters_screen";
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitledAppBar(title: "Filters"),
      body: FiltersList.selectedFilters.isEmpty
          ? Center(
              child: TextView(
                "No Filters",
                style: myTextStyle.font_14w500Black,
              ),
            )
          : ListView(
              physics: const BouncingScrollPhysics(),
              padding: 16.paddingTop(context),
              children: FiltersList.selectedFilters
                  .map(
                    (filter) => MyFilterWidget(value: filter, onTap: (val) {}),
                  )
                  .toList(),
            ),
      floatingActionButton: MyElevatedButton(
        text: "Show Sprints",
        buttonRadius: 1000,
        elevation: 4,
        textColor: MyColors.whiteFFFFFF,
        textStyle: myTextStyle.font_16w700,
        buttonBGColor: MyColors.black0D0D0D,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
