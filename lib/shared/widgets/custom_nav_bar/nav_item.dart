import 'package:flutter/material.dart';

class NavigationBarItem {
  /// An icon to display.
  final Widget icon;

  /// A primary color to use for this tab.
  final Color? selectedColor;

  /// The color to display when this tab is not selected.
  final Color? unselectedColor;

  final Widget? badgesIcon;

  NavigationBarItem({
    required this.icon,
    this.selectedColor,
    this.unselectedColor,
    this.badgesIcon,
  });
}
