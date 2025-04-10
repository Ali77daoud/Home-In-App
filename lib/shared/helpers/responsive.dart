import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 550;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 550;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width >= 550 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}
