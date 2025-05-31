import 'package:e_commerce/product_details/view/product_details.dart';
import 'package:e_commerce/products/presentation/cubit/products_cubit.dart';
import 'package:e_commerce_data/products_data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ProductsSuccess extends StatefulWidget {
  const ProductsSuccess({
    super.key,
    required this.products,
  });

  final Product products;

  @override
  State<ProductsSuccess> createState() => _ProductsSuccessState();
}

class _ProductsSuccessState extends State<ProductsSuccess> {
  late final ScrollController _scrollController;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ProductsCubit>().fetchProducts(page: ++_page);
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    return _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final products = widget.products.data ?? [];

    return products == []
        ? const Center(
            child: Text("محصولی برای نمایش وحود ندارد"),
          )
        : Column(
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: Expanded(
                  flex: 9,
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.push(
                              context,
                              ProductDetails.route(
                                  widget.products.data![index].id),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: theme.colorScheme.outline,
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 7,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      // color: theme.colorScheme.secondaryContainer,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(7),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.image,
                                      size: 120,
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 0,
                                  thickness: 0.5,
                                  color: theme.colorScheme.outlineVariant,
                                ),
                                Flexible(
                                  flex: 2,
                                  child: SizedBox(
                                    width: 180,
                                    child: Center(
                                      child: Text(
                                        widget.products.data![index].name,
                                        style:
                                            theme.textTheme.bodyLarge?.copyWith(
                                          color: theme.colorScheme.onSurface,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    widget.products.data![index]
                                                .stockQuantity !=
                                            0
                                        ? "${widget.products.data![index].price.toString().seRagham().toPersianDigit()} تومان"
                                        : "ناموجود",
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Visibility(
                  visible: context.read<ProductsCubit>().state.isLoadingMore,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.surface,
                          blurRadius: 4,
                        )
                      ],
                    ),
                    padding: const EdgeInsets.all(8.0),
                    height: 30.0,
                    width: 30.0,
                    child: CircularProgressIndicator(
                      color: theme.colorScheme.primary,
                      strokeWidth: 3.0,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
