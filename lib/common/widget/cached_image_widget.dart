import 'package:magueyapp/common/widget/network_image_error_widget.dart';
import 'package:magueyapp/common/widget/network_image_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyCachedImageWidget extends StatelessWidget {
  final String url;
  final double loaderWidth;
  final bool centerLoader;
  final EdgeInsets? loaderPadding;
  final double errorWidth;
  final double? width;
  final double? height;
  const MyCachedImageWidget({
    super.key,
    required this.url,
    this.loaderWidth = 60,
    this.centerLoader = false,
    this.loaderPadding,
    this.errorWidth = 50,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    // return errorWidget(context, "", null, errorWidth);
    return CachedNetworkImage(
      width: width,
      height: height,
      key: UniqueKey(),
      imageUrl: url,
      errorWidget: (context, text, _) =>
          errorWidget(context, text, _, errorWidth),
      progressIndicatorBuilder: (context, child, event) =>
          centerLoader ? Center(child: loaderWidget()) : loaderWidget(),
      placeholderFadeInDuration: Duration.zero,
      fadeInCurve: Curves.fastEaseInToSlowEaseOut,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 300),
    );
  }

  loaderWidget() {
    return MyImageLoader(
      width: loaderWidth,
      loaderPadding: loaderPadding,
    );
  }
}
