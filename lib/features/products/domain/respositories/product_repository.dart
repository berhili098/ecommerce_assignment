import 'package:ecommerce_assignment/features/products/domain/entiities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}
