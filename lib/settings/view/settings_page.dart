import 'package:e_commerce/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage._();

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => SettingsPage._(),
    );
  }

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final themeMode = context.read<ThemeCubit>().state.themeMode;
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(),
      body: SlidingUpPanel(
        controller: _panelController,
        defaultPanelState: PanelState.CLOSED,
        color: theme.colorScheme.surfaceBright,
        backdropEnabled: true,
        backdropColor: Colors.transparent,
        backdropOpacity: 0,
        minHeight: 0,
        maxHeight: size.height / 3.5,
        panel: ThemeRadioList(),
        body: ListView(
          children: [
            CustomSettingsOption(
              icon: themeMode.toIcon(),
              theme: theme,
              onTap: () {
                _panelController.open();
              },
              title: "حالت نمایش",
            ),
            CustomSettingsOption(
              icon: "assets/images/settings_page/question_mark.png",
              theme: theme,
              onTap: () {},
              title: "سوالات متداول",
            ),
            CustomSettingsOption(
              icon: "assets/images/settings_page/phone.png",
              theme: theme,
              onTap: () {},
              title: "تماس با ما",
            ),
            CustomSettingsOption(
              icon: "assets/images/settings_page/notification.png",
              theme: theme,
              onTap: () {},
              title: "اعلان‌ها",
            ),
          ],
        ),
      ),
    );
  }
}

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: SizedBox(
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
                      SizedBox(
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
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 21,
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            color: theme.colorScheme.outlineVariant,
          ),
        ],
      ),
    );
  }
}

class ThemeRadioList extends StatelessWidget {
  const ThemeRadioList({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return Column(
        children: ThemeMode.values.map((theme) {
      return BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return RadioListTile<ThemeMode>(
              value: theme,
              title: Text(
                theme.toFarsi(),
                style: appTheme.textTheme.labelLarge
                    ?.copyWith(color: appTheme.colorScheme.onSurface),
                textDirection: TextDirection.rtl,
              ),
              fillColor: WidgetStatePropertyAll(appTheme.colorScheme.onSurface),
              groupValue: state.themeMode,
              onChanged: (newTheme) {
                if (newTheme != null) {
                  context.read<ThemeCubit>().setTheme(newTheme);
                }
              });
        },
      );
    }).toList());
  }
}

extension on ThemeMode {
  String toFarsi() {
    switch (this) {
      case ThemeMode.system:
        return "خودکار(پیش‌فرض سیستم)";
      case ThemeMode.dark:
        return "تاریک";
      case ThemeMode.light:
        return "روشن";
    }
  }

  String toIcon() {
    switch (this) {
      case ThemeMode.system:
        return "assets/images/settings_page/system.png";
      case ThemeMode.dark:
        return "assets/images/settings_page/dark.png";
      case ThemeMode.light:
        return "assets/images/settings_page/light.png";
    }
  }
}
