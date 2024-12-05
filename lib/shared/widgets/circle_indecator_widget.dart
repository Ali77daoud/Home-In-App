import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../constants/color_constants.dart';

class CircleIndicatorWidget extends StatelessWidget {
  final bool isBgWhite;
  const CircleIndicatorWidget({super.key, this.isBgWhite = false});

  @override
  Widget build(BuildContext context) {
    final spinkit = SpinKitCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? AppColors.primaryDark : AppColors.blackDark,
          ),
        );
      },
    );
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: isBgWhite ? AppColors.white : Colors.black.withOpacity(0.3),
        ),
        spinkit,
      ],
    );
  }
}
