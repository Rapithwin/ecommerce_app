import 'package:e_commerce/orders/presentation/view/orders_page.dart';
import 'package:e_commerce/profile/presentation/view/edit_details.dart';
import 'package:e_commerce/settings/view/settings_page.dart';
import 'package:e_commerce/settings/widgets/custom_options.dart';
import 'package:flutter/material.dart';

class ProfileLoaded extends StatelessWidget {
  const ProfileLoaded({super.key});

  Widget infoText(String title, ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
        textDirection: TextDirection.ltr,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);
    return Column(
      children: <Widget>[
        Card(
          color: theme.colorScheme.surfaceBright.withAlpha(180),
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              EditDetailsPage.route(),
            ),
            child: SizedBox(
              width: size.width,
              height: size.height / 5,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 15.0,
                  left: 12.0,
                ),
                child: Column(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "نام نام خانوادگی",
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    infoText("Username", theme),
                    SizedBox(
                      height: 10,
                    ),
                    infoText("test@example.com", theme),
                    SizedBox(
                      height: 10,
                    ),
                    infoText("+989000000000", theme),
                  ],
                ),
              ),
            ),
          ),
        ),
        CustomSettingsOption(
          theme: theme,
          title: "سفارش‌ها",
          onTap: () => Navigator.push(
            context,
            OrdersPage.route(),
          ),
          icon: "assets/images/profile_page/orders.png",
        ),
        CustomSettingsOption(
          theme: theme,
          title: "تنظیمات",
          onTap: () => Navigator.push(
            context,
            SettingsPage.route(),
          ),
          icon: "assets/images/profile_page/settings.png",
        ),
      ],
    );
  }
}
