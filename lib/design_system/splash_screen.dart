import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 428,
      height: 926,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          Positioned(
            left: 370,
            top: -184,
            child: Transform(
              transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.11),
              child: Container(
                width: 503.54,
                height: 728.45,
                decoration: const BoxDecoration(color: Color(0xFFA054A0)),
              ),
            ),
          ),
          Positioned(
            left: 80,
            top: 313,
            child: Container(
              width: 267.69,
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/mascot.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 892,
            child: Container(
              width: 428,
              height: 34,
              padding: const EdgeInsets.only(
                top: 21,
                left: 147,
                right: 147,
                bottom: 8,
              ),
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 134,
                    height: 5,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF0E1215),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
