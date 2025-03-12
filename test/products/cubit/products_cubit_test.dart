import 'package:e_commerce/products/presentation/cubit/products_cubit.dart';
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
  });
}
