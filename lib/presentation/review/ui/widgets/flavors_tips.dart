import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:magueyapp/common/widget/text_view.dart';
import 'package:magueyapp/presentation/product/model/flavor_model.dart';
import 'package:magueyapp/presentation/review/redux/action.dart';
import 'package:magueyapp/presentation/review/redux/reducer.dart';
import 'package:magueyapp/presentation/review/redux/store.dart';
import 'package:magueyapp/presentation/review/ui/widgets/wrapping_chip_widget.dart';
import 'package:magueyapp/theme/text_styling.dart';
import 'package:magueyapp/utils/extensions/padding.dart';
import 'package:magueyapp/utils/extensions/sized_box.dart';

class LabeledFlavorsChipColumnView extends StatelessWidget {
  final List<FlavorModel> flavors;
  final String text;
  final double space;
  final Widget? trailingWidget;
  final double rightTrailingMargin;
  const LabeledFlavorsChipColumnView({
    super.key,
    required this.flavors,
    required this.text,
    this.space = 14,
    this.trailingWidget,
    this.rightTrailingMargin = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (trailingWidget == null)
          TextView(
            text,
            style: myTextStyle.font_15w700Black,
            padding: 16.paddingLeft(context),
          ),
        if (trailingWidget != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextView(
                text,
                style: myTextStyle.font_15w700Black,
                padding: 16.paddingLeft(context),
              ),
              const Spacer(),
              trailingWidget!,
              rightTrailingMargin.hSpace(context),
            ],
          ),
        space.vSpace(context),
        Center(
          child: StoreBuilder<ReviewState>(
            builder: (context, store) => WrappingChipWidget(
              flavors: flavors,
              onTap: (flavor) => onFlavorChipTap(flavor),
            ),
          ),
        ),
      ],
    );
  }

  void onFlavorChipTap(FlavorModel flavor) {
    if (flavor.selected) {
      reviewStore.dispatch(RemoveFlavorFromReviewAction(flavor: flavor));
    } else {
      reviewStore.dispatch(AddFlavorToReviewAction(flavor: flavor));
    }
  }
}
