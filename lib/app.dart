import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/authentication/presentation/view/login_page.dart';
import 'package:e_commerce/profile/presentation/bloc/profile_cubit.dart';
import 'package:e_commerce/root/view/root.dart';
import 'package:e_commerce/splash_screen.dart';
import 'package:e_commerce/theme/app_theme.dart';
import 'package:e_commerce/theme/cubit/theme_cubit.dart';
import 'package:e_commerce_repository/ecommerce_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductsRepostitory>(
          create: (context) => ProductsRepostitory(),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider<CartRepository>(
          create: (context) => CartRepository(),
          dispose: (repository) => repository.dispose(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (context) => ThemeCubit(),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
          BlocProvider(
            create: (context) => ProfileCubit(context.read<AuthRepository>()),
          )
        ],
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  AppView({super.key});
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          navigatorKey: _navigatorKey,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: state.themeMode,
          builder: (context, child) {
            return BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (!context.mounted) return;
                switch (state) {
                  case Authenticated():
                    context.read<ProfileCubit>().fetchUserDetails(state.token);
                    _navigator.pushAndRemoveUntil(
                        RootPage.route(), (route) => false);
                  case Unauthenticated():
                    _navigator.pushAndRemoveUntil(
                        LoginPage.route(), (route) => false);
                  default:
                }
              },
              child: child,
            );
          },
          onGenerateRoute: (_) => MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          ),
        );
      },
    );
  }
}
