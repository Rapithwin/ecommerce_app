import 'package:flutter/material.dart';

class AppBarWidgets {
  static List<Widget> appBarActions(Size size, ThemeData theme) {
    return [
      size.width < 800
          ? Expanded(
              child: Column(
                children: _widgetList(
                  size,
                  theme,
                ),
              ),
            )
          : Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: _widgetList(
                    size,
                    theme,
                  ),
                ),
              ),
            )
    ];
  }

  static List<Widget> _widgetList(
    Size size,
    ThemeData theme,
  ) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "محصولات",
            textDirection: TextDirection.rtl,
            style: theme.textTheme.headlineLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    ];
  }
}
