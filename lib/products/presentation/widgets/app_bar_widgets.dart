import 'package:flutter/material.dart';

class AppBarWidgets {
  static List<Widget> appBarActions(Size size, ThemeData theme) {
    final sreachBarController = SearchController();
    return [
      size.width < 800
          ? Expanded(
              child: Column(
                children: _widgetList(size, theme, sreachBarController),
              ),
            )
          : Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: _widgetList(
                    size,
                    theme,
                    sreachBarController,
                    flex: (size.width / 250).toInt(),
                  ),
                ),
              ),
            )
    ];
  }

  static List<Widget> _widgetList(
    Size size,
    ThemeData theme,
    SearchController sreachBarController, {
    int? flex,
  }) {
    return [
      Flexible(
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
      Flexible(
        flex: flex ?? 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: size.height / 18,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SearchBar(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                controller: sreachBarController,
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
          ),
        ),
      )
    ];
  }
}
