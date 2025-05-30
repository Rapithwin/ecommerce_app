import 'package:flutter/material.dart';

class CustomSettingsOption extends StatelessWidget {
  const CustomSettingsOption({
    super.key,
    required this.theme,
    required this.title,
    required this.onTap,
    required this.icon,
  });

  final ThemeData theme;
  final String title;
  final VoidCallback onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: TextDirection.rtl,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Image.asset(
                        icon,
                        color: theme.colorScheme.onSurface,
                        width: 35,
                        height: 35,
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 21,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: 1,
              color: theme.colorScheme.outlineVariant,
            ),
          ],
        ),
      ),
    );
  }
}
