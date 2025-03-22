import 'package:e_commerce/profile/presentation/widgets/app_bar_widgets.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: AppBarWidgets.appBarActions(
          size,
          theme,
          context,
        ),
      ),
    );
  }
}
