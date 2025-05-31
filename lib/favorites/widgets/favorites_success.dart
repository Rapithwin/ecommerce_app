import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_data/favorites_data/models/favorites_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class FavoritesSuccess extends StatelessWidget {
  const FavoritesSuccess({super.key, required this.items});

  final List<FavoritedItems> items;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);

    return items.isEmpty
        ? const Center(
            child: Text("لیست علاقه‌مندی‌ها خالی است"),
          )
        : Scaffold(
            body: BlocListener<CartBloc, CartState>(
              listener: (context, state) {
                if (state is CartError) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          "محصول به سبد خرید اضافه نشد",
                          textDirection: TextDirection.rtl,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.onError,
                          ),
                        ),
                        backgroundColor: theme.colorScheme.error,
                      ),
                    );
                } else if (state is CartLoaded) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          "محصول به سبد خرید اضافه شد",
                          textDirection: TextDirection.rtl,
                          style: theme.textTheme.labelLarge,
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                }
              },
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 600,
                        ),
                        child: Container(
                          height: size.height / 7,
                          // width: size.width,

                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHigh,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            border: Border.all(
                              color: theme.colorScheme.outline,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Flexible(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      items[index].productName!,
                                      textDirection: TextDirection.rtl,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style:
                                          theme.textTheme.bodyLarge?.copyWith(
                                        color:
                                            theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            final authState =
                                                context.read<AuthBloc>().state;
                                            if (authState is Authenticated) {
                                              context
                                                  .read<FavoritesCubit>()
                                                  .removeFavorite(
                                                    authState.token,
                                                    items[index].id!,
                                                  );
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Expanded(
                                            child: SizedBox(
                                              child: ElevatedButton(
                                                style: theme
                                                    .elevatedButtonTheme.style,
                                                onPressed: () {
                                                  final authState = context
                                                      .read<AuthBloc>()
                                                      .state;
                                                  if (authState
                                                      is Authenticated) {
                                                    context
                                                        .read<CartBloc>()
                                                        .add(AddItemToCart(
                                                            items[index]
                                                                .productId!,
                                                            1,
                                                            authState.token));
                                                  }
                                                },
                                                child: Text(
                                                  "افزودن به سبد خرید",
                                                  style: theme
                                                      .textTheme.labelLarge
                                                      ?.copyWith(
                                                    color: theme
                                                        .colorScheme.onSurface,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            "${items[index].productPrice?.round().toString().seRagham().toPersianDigit()} تومان",
                                            style: theme.textTheme.bodyLarge
                                                ?.copyWith(
                                              color: theme
                                                  .colorScheme.onSurfaceVariant,
                                            ),
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image(
                                    loadingBuilder:
                                        (context, child, loadingProgress) =>
                                            const Placeholder(),
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Placeholder(),
                                    image: const NetworkImage(
                                        "https://static.owayo-cdn.com/newhp/img/productHome/productSeitenansicht/productservice/tshirts_classic_herren_basic_productservice/st2020_gyh.png"),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }
}
