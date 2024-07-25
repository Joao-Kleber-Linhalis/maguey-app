import 'package:flutter/material.dart';
import 'package:magueyapp/presentation/product/model/flavor_model.dart';
import 'package:magueyapp/presentation/product/ui/widgets/product_details/top_flavors/custom_tooltip_widget.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';

class TopFlavors extends StatelessWidget {
  final List<FlavorModel> topFlavours;
  final int totalValue;
  final Color color;
  final double width;
  const TopFlavors({
    super.key,
    required this.topFlavours,
    required this.color,
    required this.totalValue,
    this.width = 240,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width + 50,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: width,
              height: 10.pxV(context),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Row(
                  children: [
                    if (topFlavours.length == 1)
                      Container(
                        width: getWidth(topFlavours[0].value),
                        color: color,
                      ),
                    if (topFlavours.length == 2) ...[
                      Container(
                        width: getWidth(topFlavours[0].value),
                        color: color,
                      ),
                      Container(
                        width: getWidth(topFlavours[1].value),
                        color: color.withOpacity(0.6),
                      ),
                    ],
                    if (topFlavours.length >= 3) ...[
                      Container(
                        width: getWidth(topFlavours[0].value),
                        color: color,
                      ),
                      Container(
                        width: getWidth(topFlavours[1].value),
                        color: color.withOpacity(0.6),
                      ),
                      Container(
                        width: getWidth(topFlavours[2].value),
                        color: color.withOpacity(0.4),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          if (topFlavours.length == 1)
            Positioned(
              bottom: 0,
              left: getWidth(topFlavours[0].value) / 2,
              child: ToolTipImage(
                message: topFlavours[0].name,
                rotate: true,
              ),
            ),
          if (topFlavours.length == 2) ...[
            Positioned(
              left: 20 +
                  getWidth(topFlavours[0].value) +
                  getWidth(topFlavours[1].value) / 2.5,
              child: ToolTipImage(
                // message: topFlavours[1].name,
                message: topFlavours[1].name,
              ),
            ),
            Positioned(
              bottom: 0,
              left: getWidth(topFlavours[0].value) / 2,
              child: ToolTipImage(
                message: topFlavours[0].name,
                rotate: true,
              ),
            ),
          ],
          if (topFlavours.length >= 3) ...[
            Positioned(
              left: 20 +
                  getWidth(topFlavours[0].value) +
                  getWidth(topFlavours[1].value) / 2.5,
              child: ToolTipImage(
                // message: topFlavours[1].name,
                message: topFlavours[1].name,
              ),
            ),
            Positioned(
              bottom: 0,
              left: getWidth(topFlavours[0].value) / 2,
              child: ToolTipImage(
                message: topFlavours[0].name,
                rotate: true,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 20,
              // left: 20
              //     getWidth(topFlavours[0].value) +
              //     getWidth(topFlavours[1].value) +
              //     getWidth(topFlavours[2].value),
              child: ToolTipImage(
                message: topFlavours[2].name,
                rotate: true,
              ),
            ),
          ]
        ],
      ),
    );
  }

  double getWidth(int value) => (value / totalValue) * width;
}
