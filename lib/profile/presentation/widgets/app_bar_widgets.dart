import 'package:flutter/material.dart';

class AppBarWidgets {
  static List<Widget> appBarActions(
    Size size,
    ThemeData theme,
    BuildContext context,
  ) {
    return [
      SizedBox(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "پروفایل",
                  textDirection: TextDirection.rtl,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ];
  }
}
