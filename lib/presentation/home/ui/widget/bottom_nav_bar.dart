import 'package:flutter_svg/flutter_svg.dart';
import 'package:magueyapp/theme/my_colors.dart';
import 'package:magueyapp/theme/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/utils/extensions/media_query.dart';
import 'package:magueyapp/utils/extensions/padding.dart';

class MyFloatingBottomNavbar extends StatefulWidget {
  final double homePadding, favouritesPadding, shopPadding;
  final double locationPadding;
  final Function(int) onTap;
  final int currentIndex;
  final Duration animateionDuraiton;
  final Curve animationCurve;
  const MyFloatingBottomNavbar({
    super.key,
    this.homePadding = 40,
    this.favouritesPadding = 276,
    this.shopPadding = 115,
    this.locationPadding = 195,
    required this.onTap,
    required this.currentIndex,
    required this.animateionDuraiton,
    required this.animationCurve,
  });

  @override
  State<MyFloatingBottomNavbar> createState() => _MyFloatingBottomNavbarState();
}

class _MyFloatingBottomNavbarState extends State<MyFloatingBottomNavbar> {
  // int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.percentWidth(context),
      height: 65.pxH(context),
      margin: 16.paddingAll(context),
      decoration: BoxDecoration(
        color: MyColors.greyF6F8FA,
        borderRadius: BorderRadius.circular(100.percentWidth(context)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(33, 0, 0, 0),
            spreadRadius: -1,
            blurRadius: 6.pxV(context),
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // AnimatedPositioned(child: , duration: duration),
          AnimatedPositioned(
            duration: widget.animateionDuraiton,
            curve: widget.animationCurve,
            left: getCurrentPosition().pxH(context),
            child: Container(
              height: 34,
              width: 34,
              decoration: BoxDecoration(
                color: MyColors.black0D0D0D,
                borderRadius: BorderRadius.circular(100.percentHeight(context)),
              ),
            ),
          ),
          Positioned(
            left: widget.homePadding.pxH(context),
            top: 65.pxH(context) / 2 - 13,
            child: InkWell(
              onTap: () => widget.onTap(0),
              child: SvgPicture.asset(
                height: 23.5,
                MyIcons.groupIcon,
                color: widget.currentIndex == 0
                    ? MyColors.whiteFFFFFF
                    : MyColors.black0D0D0D,
              ),
            ),
          ),
          Positioned(
            left: widget.locationPadding.pxH(context),
            top: 65.pxH(context) / 2 - 11,
            child: InkWell(
              onTap: () => widget.onTap(2),
              child: Icon(
                Icons.calendar_today,
                color: widget.currentIndex == 2
                    ? MyColors.whiteFFFFFF
                    : MyColors.black0D0D0D,
                size: 22,
              ),

              // SvgPicture.asset(
              //   height: 24,
              //   MyIcons.locationIcon,
              //   color: widget.currentIndex == 2
              //       ? MyColors.whiteFFFFFF
              //       : MyColors.black0D0D0D,
              // ),
            ),
          ),
          Positioned(
            left: widget.shopPadding.pxH(context),
            top: 65.pxH(context) / 2 - 13,
            child: InkWell(
              onTap: () => widget.onTap(1),
              child: SvgPicture.asset(
                // MyIcons.shopIcon,
                MyIcons.locationIcon,
                height: 24,
                color: widget.currentIndex == 1
                    ? MyColors.whiteFFFFFF
                    : MyColors.black0D0D0D,
              ),
            ),
          ),
          Positioned(
            left: widget.favouritesPadding.pxH(context),
            top: 65.pxH(context) / 2 - 11,
            child: InkWell(
              onTap: () => widget.onTap(3),
              child: SvgPicture.asset(
                MyIcons.heartIcon,
                height: 24,
                color: widget.currentIndex == 3
                    ? MyColors.whiteFFFFFF
                    : MyColors.black0D0D0D,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double getCurrentPosition() {
    switch (widget.currentIndex) {
      case 2:
        return widget.locationPadding - 5.5;
      case 1:
        return widget.shopPadding - 5;
      case 0:
        return widget.homePadding - 5.2;
      default:
        return widget.favouritesPadding - 5.3;
    }
  }
}
