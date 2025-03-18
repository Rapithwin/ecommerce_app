import 'package:flutter/material.dart';

class AppBarWidgets {
  static List<Widget> appBarActions(Size size, ThemeData theme) {
    return [
      SizedBox(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/images/profile_page/settings.png",
                  color: theme.colorScheme.secondary,
                  height: 40,
                  width: 40,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "پروفایل",
                  textDirection: TextDirection.rtl,
                  style: theme.textTheme.headlineLarge,
                ),
              ),
            ],
          ),
        ),
      )
    ];
  }
}
