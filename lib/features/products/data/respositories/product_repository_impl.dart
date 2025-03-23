import 'package:ecommerce_assignment/features/products/data/data_source/product_remote_datasource.dart';
import 'package:ecommerce_assignment/features/products/domain/entiities/product.dart';
import 'package:ecommerce_assignment/features/products/domain/respositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductDataSource productDataSource;

  ProductRepositoryImpl(this.productDataSource);

  @override
  Future<List<Product>> getProducts() async {
    final products = await productDataSource.getProducts();
    return products.map((p) => p.toEntity()).toList();
  }
}
