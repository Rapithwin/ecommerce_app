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
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: state.themeMode,
          home: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (!context.mounted) return;
              switch (state) {
                case Authenticated():
                  Navigator.pushReplacement(context, RootPage.route());
                  context.read<ProfileCubit>().fetchUserDetails(state.token);

                case Unauthenticated():
                  context.read<ProfileCubit>().clearUserData();
                  Navigator.pushReplacement(context, LoginPage.route());
                default:
              }
            },
            child: SplashScreen(),
          ),
        );
      },
    );
  }
}
