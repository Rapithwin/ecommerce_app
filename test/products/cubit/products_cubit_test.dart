import 'package:e_commerce_repository/ecommerce_repository.dart'
    as products_repository show ProductsRepostitory;
import 'package:mocktail/mocktail.dart';

class MockProductsRepository extends Mock
    implements products_repository.ProductsRepostitory {}
