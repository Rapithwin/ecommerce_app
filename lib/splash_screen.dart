import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/authentication/presentation/view/login_page.dart';
import 'package:e_commerce/root/view/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = context.watch<AuthBloc>().state;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authState is Authenticated) {
        Navigator.of(context).pushReplacement(RootPage.route());
      } else if (authState is Unauthenticated) {
        Navigator.of(context).pushReplacement(LoginPage.route());
      }
    });

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushReplacement(RootPage.route());
        } else if (state is Unauthenticated) {
          Navigator.of(context).pushReplacement(LoginPage.route());
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
      ),
    );
  }
}
