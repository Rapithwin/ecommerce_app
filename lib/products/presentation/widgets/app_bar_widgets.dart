import 'package:flutter/material.dart';

class AppBarWidgets {
  static List<Widget> appBarActions(Size size, ThemeData theme) {
    return [
      Column(
        children: [
          SizedBox(
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.menu,
                      weight: 4,
                      size: 30,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "محصولات",
                      textDirection: TextDirection.rtl,
                      style: theme.textTheme.headlineLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: size.width - 30,
            height: size.height / 18,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SearchBar(
                backgroundColor:
                    WidgetStatePropertyAll(theme.colorScheme.tertiary),
                hintText: "جستجو...",
                hintStyle:
                    WidgetStatePropertyAll(theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onTertiary,
                )),
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
