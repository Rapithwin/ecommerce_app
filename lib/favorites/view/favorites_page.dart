import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce/favorites/widgets/widgets.dart';
import 'package:e_commerce/profile/presentation/widgets/widgets.dart';
import 'package:e_commerce/root/cubit/root_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RootCubit, RootState>(
      listener: (context, rootState) {
        final authState = context.read<AuthBloc>().state;
        if (authState is Authenticated && rootState.tab == RootTab.favorites) {
          context.read<FavoritesCubit>().fetchFavorites(authState.token);
        }
      },
      child: const FavoritesView(),
    );
  }
}

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

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
          title: "علاقه‌مندی‌ها",
          context,
        ),
      ),
      body: Expanded(
        child: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            return switch (state.status) {
              FavoritesStatus.initial => const FavoritesLoading(),
              FavoritesStatus.loading => const FavoritesLoading(),
              FavoritesStatus.failure => FavoritesFailure(
                  message: state.error ?? "unknown",
                ),
              FavoritesStatus.success => FavoritesSuccess(
                  items: state.favorites.data!.items ?? [],
                ),
            };
          },
        ),
      ),
    );
  }
}
