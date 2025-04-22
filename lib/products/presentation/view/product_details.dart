import 'package:e_commerce_data/products_data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key, required this.product});

  final Product product;

  static Route<ProductDetails> route(Product product) {
    return MaterialPageRoute(
      builder: (_) => ProductDetails(
        product: product,
      ),
    );
  }

  final List<String> testNetworkImg = [
    "https://static.owayo-cdn.com/newhp/img/productHome/productSeitenansicht/productservice/tshirts_classic_herren_basic_productservice/tshirt_basic_4.jpg",
    "https://static.owayo-cdn.com/newhp/img/productHome/productSeitenansicht/productservice/tshirts_classic_herren_basic_productservice/st2020_gyh.png",
    "https://static.owayo-cdn.com/newhp/img/productHome/productSeitenansicht/productservice/tshirts_classic_herren_basic_productservice/st2020_whi.png",
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);

    final PageController pageController = PageController();
    final convertedPrice = product.price.toString().seRagham().toPersianDigit();
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shadowColor: theme.colorScheme.shadow,
        elevation: 11,
        color: theme.colorScheme.surfaceContainer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 20,
          children: <Widget>[
            Text(
              textDirection: TextDirection.rtl,
              "$convertedPrice تومان",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: SizedBox(
                width: size.width / 1.6,
                height: size.height / 10,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    "افزودن به سبد خرید",
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSecondary,
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_border),
              selectedIcon: Icon(Icons.favorite),
              iconSize: 30,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height / 3,
              child: PageView.builder(
                itemCount: testNetworkImg.length,
                reverse: true,
                itemBuilder: imageBuilder,
                controller: pageController,
              ),
            ),
            SizedBox(
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
            )
          ],
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
