import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/profile/presentation/bloc/profile_cubit.dart';
import 'package:e_commerce/profile/presentation/widgets/widgets.dart';
import 'package:e_commerce_repository/ecommerce_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) {
        final cubit = ProfileCubit(context.read<AuthRepository>());
        final authState = context.read<AuthBloc>().state;

        if (authState is Authenticated) {
          cubit.fetchUserDetails(authState.token);
        }
        return cubit;
      },
      child: ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surfaceContainerLow,
        actions: AppBarWidgets.appBarActions(
          size,
          theme,
          title: "پروفایل",
          context,
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return switch (state.status) {
            ProfileStatus.initial => const ProfileLoading(),
            ProfileStatus.loading => const ProfileLoading(),
            ProfileStatus.failure => const ProfileFailure(),
            ProfileStatus.success => ProfileLoaded(userdata: state.userData!),
          };
        },
      ),
    );
  }
}
