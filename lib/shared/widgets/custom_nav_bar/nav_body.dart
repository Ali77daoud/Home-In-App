import 'package:flutter/material.dart';
import '../../helpers/responsive.dart';
import 'nav_item.dart';

class NavBody extends StatelessWidget {
  const NavBody({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.curve,
    required this.duration,
    required this.selectedItemColor,
    required this.theme,
    required this.unselectedItemColor,
    required this.onTap,
    required this.itemPadding,
    required this.dotIndicatorColor,
    required this.enablePaddingAnimation,
    this.splashBorderRadius,
    this.splashColor,
  });

  final List<NavigationBarItem> items;
  final int currentIndex;
  final Curve curve;
  final Duration duration;
  final Color? selectedItemColor;
  final ThemeData theme;
  final Color? unselectedItemColor;
  final Function(int index) onTap;
  final EdgeInsets itemPadding;
  final Color? dotIndicatorColor;
  final bool enablePaddingAnimation;
  final Color? splashColor;
  final double? splashBorderRadius;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final item in items)
          TweenAnimationBuilder<double>(
            tween: Tween(
              end: items.indexOf(item) == currentIndex ? 1 : 0.0,
            ),
            curve: curve,
            duration: duration,
            builder: (context, t, _) {
              final selectedColor =
                  item.selectedColor ?? selectedItemColor ?? theme.primaryColor;

              final unselectedColor = item.unselectedColor ??
                  unselectedItemColor ??
                  theme.iconTheme.color;

              return Material(
                color: Color.lerp(Colors.transparent, Colors.transparent, t),
                borderRadius: BorderRadius.circular(splashBorderRadius ?? 8),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => onTap.call(items.indexOf(item)),
                  focusColor: splashColor ?? selectedColor.withOpacity(0.1),
                  highlightColor: splashColor ?? selectedColor.withOpacity(0.1),
                  splashColor: splashColor ?? selectedColor.withOpacity(0.1),
                  hoverColor: splashColor ?? selectedColor.withOpacity(0.1),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: itemPadding -
                              (enablePaddingAnimation
                                  ? EdgeInsets.only(
                                      right: (itemPadding.right / 1.7) * t)
                                  : EdgeInsets.zero),
                          child: IconTheme(
                            data: IconThemeData(
                              color:
                                  Color.lerp(unselectedColor, selectedColor, t),
                              size: Responsive.isMobile(context) ? 24 : 22,
                            ),
                            child: item.icon,
                          ),
                        ),
                        ClipRect(
                          child: SizedBox(
                            height: 40,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              widthFactor: t,
                              child: Padding(
                                padding: EdgeInsetsDirectional.only(
                                    start: itemPadding.right / 0.55,
                                    end: itemPadding.right),
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    color: Color.lerp(
                                        selectedColor.withOpacity(0.0),
                                        selectedColor,
                                        t),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  child: CircleAvatar(
                                    radius:
                                        Responsive.isMobile(context) ? 2.5 : 2,
                                    backgroundColor:
                                        dotIndicatorColor ?? selectedColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ////////////////
                        item.badgesIcon != null
                            ? Positioned(
                                top: 0,
                                right: 4,
                                child: item.badgesIcon!,
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
