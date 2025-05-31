import 'package:e_commerce/authentication/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_data/products_data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailsSuccess extends StatefulWidget {
  const DetailsSuccess({super.key, required this.product});

  final Product product;

  @override
  State<DetailsSuccess> createState() => _DetailsSuccessState();
}

class _DetailsSuccessState extends State<DetailsSuccess> {
  final List<String> testNetworkImg = [
    "https://static.owayo-cdn.com/newhp/img/productHome/productSeitenansicht/productservice/tshirts_classic_herren_basic_productservice/tshirt_basic_4.jpg",
    "https://static.owayo-cdn.com/newhp/img/productHome/productSeitenansicht/productservice/tshirts_classic_herren_basic_productservice/st2020_gyh.png",
    "https://static.owayo-cdn.com/newhp/img/productHome/productSeitenansicht/productservice/tshirts_classic_herren_basic_productservice/st2020_whi.png",
  ];

  final PageController pageController = PageController();
  bool _addedToFavoritesManually = false;
  bool _removedFromFavoritesManually = false;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      context.read<FavoritesCubit>().fetchFavorites(authState.token);
      context
          .read<FavoritesCubit>()
          .checkIsFavorited(authState.token, widget.product.data![0].id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);
    final ProductData data = widget.product.data![0];

    final convertedPrice = data.price.toString().seRagham().toPersianDigit();

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceBright,
      bottomNavigationBar: BottomAppBar(
        shadowColor: theme.colorScheme.shadow,
        elevation: 11,
        color: theme.colorScheme.surfaceContainerLow,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 20,
          children: <Widget>[
            Text(
              textDirection: TextDirection.rtl,
              data.stockQuantity != 0 ? "$convertedPrice تومان" : "ناموجود",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            Flexible(
              child: SizedBox(
                width: size.width / 1.6,
                height: size.height / 10,
                child: ElevatedButton(
                  style: theme.elevatedButtonTheme.style,
                  onPressed: data.stockQuantity != 0
                      ? () {
                          final authState = context.read<AuthBloc>().state;
                          if (authState is Authenticated) {
                            context.read<CartBloc>().add(
                                AddItemToCart(data.id, 1, authState.token));
                          }
                        }
                      : null,
                  child: Text(
                    "افزودن به سبد خرید",
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surfaceContainerLow,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, favState) {
                return IconButton(
                  onPressed: () async {
                    final authState = context.read<AuthBloc>().state;
                    if (authState is Authenticated) {
                      if (!favState.isFavorited) {
                        setState(() {
                          _addedToFavoritesManually = true;
                        });
                        await context
                            .read<FavoritesCubit>()
                            .addToFavorites(authState.token, data.id);
                        // Fetch updated favorites so the new item (with its id) is available for removal
                        if (!context.mounted) return;
                        await context
                            .read<FavoritesCubit>()
                            .fetchFavorites(authState.token);
                      } else {
                        // Find the favorite item id associated with this product id
                        final favItems = favState.favorites.data?.items ?? [];
                        final favItem = favItems.firstWhere(
                          (item) => item.productId == data.id,
                          orElse: () =>
                              null as dynamic, // workaround for null return
                        );
                        if (favItem != null && favItem.id != null) {
                          setState(() {
                            _removedFromFavoritesManually = true;
                          });
                          await context
                              .read<FavoritesCubit>()
                              .removeFavorite(authState.token, favItem.id!);
                        }
                      }
                    }
                  },
                  isSelected: favState.isFavorited,
                  icon: Image.asset(
                    "assets/images/icons/heart-outlined.png",
                    height: 40,
                    width: 40,
                    color: theme.colorScheme.onSurface,
                  ),
                  selectedIcon: Image.asset(
                    "assets/images/icons/heart-filled.png",
                    height: 40,
                    width: 40,
                    color: theme.colorScheme.onSurface,
                  ),
                  iconSize: 30,
                );
              },
            ),
          )
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CartBloc, CartState>(
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
          ),
          BlocListener<FavoritesCubit, FavoritesState>(
            listenWhen: (previous, current) =>
                previous.isFavorited == false && current.isFavorited == true,
            listener: (context, state) {
              if (_addedToFavoritesManually) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        "محصول به لیست علاقه‌مندی‌ها اضافه شد",
                        textDirection: TextDirection.rtl,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onError,
                        ),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                setState(() {
                  _addedToFavoritesManually = false;
                });
              }
            },
          ),
          BlocListener<FavoritesCubit, FavoritesState>(
            listenWhen: (previous, current) =>
                previous.isFavorited == true && current.isFavorited == false,
            listener: (context, state) {
              if (_removedFromFavoritesManually) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        "محصول از لیست علاقه‌مندی‌ها حذف شد",
                        textDirection: TextDirection.rtl,
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onError,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                setState(() {
                  _removedFromFavoritesManually = false;
                });
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: size.height / 3,
                  child: PageView.builder(
                    itemCount: testNetworkImg.length,
                    reverse: true,
                    itemBuilder: imageBuilder,
                    controller: pageController,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SmoothPageIndicator(
                  textDirection: TextDirection.rtl,
                  controller: pageController,
                  count: testNetworkImg.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    expansionFactor: 2,
                    activeDotColor: theme.colorScheme.secondary,
                    dotColor: theme.colorScheme.onSurface.withAlpha(60),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                UserRatings(theme: theme),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      data.name,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Material(
                      color: Colors.transparent,
                      textStyle: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                        wordSpacing: 0.4,
                      ),
                      child: ReadMoreText(
                        data.description,
                        trimCollapsedText: "بیشتر",
                        trimExpandedText: "بستن",
                        trimLength: 450,
                        moreStyle: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        lessStyle: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imageBuilder(
    BuildContext context,
    int index,
  ) {
    return Image(
      image: NetworkImage(testNetworkImg[index]),
      fit: BoxFit.fitHeight,
    );
  }
}

class UserRatings extends StatelessWidget {
  const UserRatings({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 35,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: theme.colorScheme.secondaryContainer,
              ),
              child: Center(
                child: Text(
                  "${"1111".toPersianDigit()} نظر",
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  "4.3",
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.star,
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
