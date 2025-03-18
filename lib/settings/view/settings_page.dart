import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage._();

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const SettingsPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Divider(
            height: 1,
          ),
          InkWell(
            onTap: () {},
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
    );
  }
}
