import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/common/widget/my_buttons/my_elevated_button.dart';
import 'package:magueyapp/common/widget/my_horizontal_margin.dart';
import 'package:magueyapp/presentation/catrgory/ui/widgets/titled_app_bar.dart';
import 'package:magueyapp/presentation/product/redux/product_state.dart';
import 'package:magueyapp/presentation/review/ui/widgets/flavors_tips.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/route_extension.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class AddFlavorTagScreen extends StatefulWidget {
  static const String route = "add_flavor_tags";
  const AddFlavorTagScreen({super.key});

  @override
  State<AddFlavorTagScreen> createState() => _AddFlavorTagScreenState();
}

class _AddFlavorTagScreenState extends State<AddFlavorTagScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TitledAppBar(title: "Flavor Tags"),
      body: StoreConnector<ProductState, ProductState>(
        converter: (store) => store.state,
        builder: (context, state) => ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            16.vSpace(context),
            // MyTextFormField(
            //   margin: 16.paddingH(context),
            //   prefixConstraints:
            //       const BoxConstraints(maxHeight: 17, minWidth: 16),
            //   hintText: "Search",
            //   prefixIcon: Padding(
            //     padding: 15.paddingLeft(context),
            //     child: SvgPicture.asset(
            //       MyIcons.searchBoldIcon,
            //       color: MyColors.greyAFAFB7,
            //     ),
            //   ),
            //   prefix: 5.hSpace(context),
            //   hintStyle: myTextStyle.font_14w500Black.w600
            //       .textColor(MyColors.greyAFAFB7),
            // ),
            16.vSpace(context),
            if (state.selectedProduct!.topFlavors.isNotEmpty)
              LabeledFlavorsChipColumnView(
                text: "Suggested",
                flavors: state.selectedProduct!.topFlavors,
              ),
            15.vSpace(context),
            MyHorizontalDivider(margin: 16.paddingH(context)),
            12.vSpace(context),
            LabeledFlavorsChipColumnView(
              text: "All",
              flavors: state.selectedProduct!.flavors,
            ),
          ],
        ),
      ),
      floatingActionButton: MyElevatedButton(
        text: "Confirm",
        buttonRadius: 1000,
        textColor: MyColors.whiteFFFFFF,
        textStyle: myTextStyle.font_16w700,
        buttonBGColor: MyColors.black0D0D0D,
        onPressed: () => context.pop(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
