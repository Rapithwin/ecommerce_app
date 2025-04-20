import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_data/products_data/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final Product product;

  static Route<ProductDetails> route(Product product) {
    return MaterialPageRoute(
      builder: (_) => ProductDetails(
        product: product,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
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
            CarouselSlider.builder(
              itemCount: 3,
              itemBuilder: imageBuilder,
              options: CarouselOptions(
                viewportFraction: 1,
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
    int realIndex,
  ) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.sizeOf(context);

    final List<String> testNetworkImg = [
      "https://www.mountaingoatsoftware.com/uploads/blog/2016-09-06-what-is-a-product.png",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9YL_gULeR_w6Vus30JxsM0lGuiHFHmJKG5Q&s",
      "https://media.istockphoto.com/id/1193723594/photo/fujiyoshida-japan-at-chureito-pagoda-and-mt-fuji-in-the-spring-with-cherry-blossoms.jpg?s=612x612&w=0&k=20&c=O5Oy6Bxa7rJs6eqVu4h85OxDd-yBnUVfJ_cAyt5P6iY=",
    ];

    return Image(
      image: NetworkImage(testNetworkImg[index]),
    );
  }
}
