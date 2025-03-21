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
    return Scaffold(
      appBar: AppBar(),
      body: SlidingUpPanel(
        controller: _panelController,
        defaultPanelState: PanelState.CLOSED,
        color: theme.colorScheme.primary,
        backdropEnabled: true,
        backdropColor: Colors.transparent,
        backdropOpacity: 0.1,
        minHeight: 0,
        panel: ThemeRadioList(),
        body: ListView(
          children: [
            Divider(
              height: 1,
            ),
            InkWell(
              onTap: () {
                _panelController.open();
              },
              child: Container(
                height: 60,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textDirection: TextDirection.rtl,
                    children: [
                      Text(
                        "حالت نمایش",
                        style: theme.textTheme.labelLarge,
                      ),
                      Icon(
                        Icons.arrow_back_ios,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
              height: 50,
            )
          ],
        ),
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
                style: appTheme.textTheme.labelLarge,
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
}
