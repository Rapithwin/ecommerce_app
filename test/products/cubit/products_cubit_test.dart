import 'package:bloc_test/bloc_test.dart';
import 'package:e_commerce/products/presentation/cubit/products_cubit.dart';
import 'package:e_commerce_data/products_data/models/product.dart';
import 'package:e_commerce_repository/ecommerce_repository.dart'
    as products_repository show ProductsRepostitory;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockProductsRepository extends Mock
    implements products_repository.ProductsRepostitory {}

void main() {
  group("ProductsCubit", () {
    late products_repository.ProductsRepostitory repository;
    late ProductsCubit cubit;

    setUp(() {
      repository = MockProductsRepository();
      cubit = ProductsCubit(repository);
    });

    test("Initial state is correct", () {
      cubit = ProductsCubit(repository);
      expect(cubit.state, ProductsState());
    });

    group("fetchProducts", () {
      blocTest<ProductsCubit, ProductsState>(
        'emits [loading, failure] when fetchProducts throws.',
        setUp: () {
          when(() => repository.getProducts()).thenThrow(Exception("oops"));
        },
        build: () => cubit,
        act: (cubit) => cubit.fetchProducts(),
        expect: () => <ProductsState>[
          ProductsState(status: ProductsStatus.loading),
          ProductsState(status: ProductsStatus.failure),
        ],
      );
    });
    blocTest<ProductsCubit, ProductsState>(
      'emits [loading, success] when fetchProducts returns.',
      setUp: () {
        when(() => repository.getProducts()).thenAnswer((_) async => [
              Product(
                  id: 1, name: "test", description: "test product", price: 1)
            ]);
      },
      build: () => cubit,
      act: (cubit) => cubit.fetchProducts(),
      expect: () => <dynamic>[
        ProductsState(status: ProductsStatus.loading),
        isA<ProductsState>()
            .having((p) => p.status, "status", ProductsStatus.success)
            .having(
              (p) => p.products,
              "products",
              isA<List<Product>>()
                  .having((p) => p[0].id, "id", 1)
                  .having(
                      (p) => p[0].description, "description", "test product")
                  .having((p) => p[0].name, "name", "test")
                  .having((p) => p[0].price, "price", 1),
            )
      ],
    );
  });
}
