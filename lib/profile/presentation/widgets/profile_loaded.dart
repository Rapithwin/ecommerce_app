import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/authentication/presentation/view/login_page.dart';
import 'package:e_commerce/orders/presentation/view/orders_page.dart';
import 'package:e_commerce/profile/presentation/view/edit_details.dart';
import 'package:e_commerce/settings/view/settings_page.dart';
import 'package:e_commerce/settings/widgets/custom_options.dart';
import 'package:e_commerce_data/auth_data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileLoaded extends StatelessWidget {
  const ProfileLoaded({super.key, required this.userdata});

  final UserModel userdata;

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
                      "${userdata.firstName} ${userdata.lastName}",
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    infoText(userdata.email!, theme),
                    SizedBox(
                      height: 10,
                    ),
                    infoText(userdata.phoneNumber!, theme),
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
        CustomSettingsOption(
          theme: theme,
          title: "خروج",
          onTap: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(
                  'خروج',
                  textDirection: TextDirection.rtl,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                content: Text(
                  'از حساب خود خارج می‌شوید؟',
                  textDirection: TextDirection.rtl,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('خیر', textDirection: TextDirection.rtl),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(LoggedOut());
                      Navigator.pushAndRemoveUntil(
                        context,
                        LoginPage.route(),
                        (_) => false,
                      );
                    },
                    child: const Text('بله', textDirection: TextDirection.rtl),
                  ),
                ],
              ),
            );
          },
          icon: "assets/images/profile_page/logout.png",
        ),
      ],
    );
  }
}
