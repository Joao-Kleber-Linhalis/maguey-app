import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:magueyapp/common/widget/my_toast.dart';

class ConnectivityService {
  // final Connectivity _connectivity = Connectivity();
  final GlobalKey<NavigatorState> navigatorKey;
  // bool _isFirst = false, _isChecked = false;

  ConnectivityService({required this.navigatorKey});

  static Future<bool> connected() async {
    if (await Connectivity().checkConnectivity() == ConnectivityResult.none) {
      MyToast.simple("No internet connection");
      return false;
    }
    return true;
  }

  // Future<void> initConnectivity() async {
  //   _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

  //   try {
  //     await _connectivity.checkConnectivity();
  //   } on PlatformException catch (e) {
  //     'Couldn\'t check connectivity status $e'.log();
  //     return;
  //   }
  // }

  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   if (_isFirst) {
  //     if (Platform.isIOS) {
  //       if (result != ConnectivityResult.none && !_isChecked) {
  //         _showSnackBar('Your internet connection was restored.', Icons.wifi);
  //         _isChecked = true;
  //       }
  //       if (result == ConnectivityResult.none && _isChecked) {
  //         _showSnackBar('You\'re currently offline.', Icons.wifi_off);
  //         _isChecked = false;
  //       }
  //     }
  //     if (Platform.isAndroid) {
  //       if (result != ConnectivityResult.none) {
  //         _showSnackBar('Your internet connection was restored.', Icons.wifi);
  //       }
  //       if (result == ConnectivityResult.none) {
  //         _showSnackBar('You\'re currently offline.', Icons.wifi_off);
  //       }
  //     }
  //   } else {
  //     _isFirst = true;
  //     _isChecked = true;
  //   }
  // }

  // void _showSnackBar(String message, IconData iconData) {
  //   Flushbar(
  //     flushbarPosition: FlushbarPosition.BOTTOM,
  //     margin: const EdgeInsets.all(20),
  //     borderRadius: BorderRadius.circular(6),
  //     messageText: SizedBox(
  //       height: 20,
  //       child: Row(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Icon(
  //             iconData,
  //             color: _snackBarColor(),
  //           ),
  //           const SizedBox(width: 16),
  //           Expanded(
  //             child: FittedBox(
  //               alignment: Alignment.centerLeft,
  //               child: TextView(
  //                 message,
  //                 style: TextStyleCustom.font_18Medium!.copyWith(
  //                   color: _snackBarColor(),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     backgroundColor: MyColors.black,
  //     duration: const Duration(milliseconds: 5000),
  //   ).show(navigatorKey.currentContext!);
  // }

  // Color _snackBarColor() {
  //   return MyThemeColor.textColor(
  //     navigatorKey.currentContext!,
  //     darkColor: MyColors.white,
  //     lightColor: MyColors.black,
  //   );
  // }
}
