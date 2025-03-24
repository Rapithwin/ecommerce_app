import 'package:flutter/material.dart';

class AppBarWidgets {
  static List<Widget> appBarActions(Size size, ThemeData theme) {
    return [
      Column(
        spacing: 10,
        children: [
          SizedBox(
            width: size.width,
            child: Padding(
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
          ),
          SizedBox(
            width: size.width - 30,
            height: size.height / 18,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SearchBar(
                backgroundColor: WidgetStatePropertyAll(
                    theme.colorScheme.surfaceContainerHighest),
                shadowColor: WidgetStatePropertyAll(Colors.transparent),
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                  splashRadius: 1,
                ),
                hintText: "جستجو...",
                hintStyle: WidgetStatePropertyAll(
                  theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          )
        ],
      )
    ];
  }
}
