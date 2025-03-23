import 'package:ecommerce_assignment/features/cart/data/data_source/cart_local_datasource.dart';
import 'package:ecommerce_assignment/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_assignment/features/cart/domain/repositories/cart_resporitory.dart';
import 'package:ecommerce_assignment/features/products/data/models/product_model.dart';
import 'package:ecommerce_assignment/features/products/domain/entiities/product.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDataSource dataSource;

  CartRepositoryImpl(this.dataSource);

  @override
  Future<void> addToCart(Product product) async {
    await dataSource.addToCart(ProductModel.fromEntity(product));
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    final cartItems = await dataSource.getCartItems();
    return cartItems.map((item) => item.toEntity()).toList();
  }

  @override
  Future<void> removeFromCart(int productId) async {
    await dataSource.removeFromCart(productId);
  }

  @override
  Future<void> clearCart() async {
    await dataSource.clearCart();
  }
  
  @override
  Future<void> decrementQuantity(int id)async {
    await dataSource.decrementQuantity(id);
  }
  
  @override
  Future<void> incrementQuantity(int id)async {
    await dataSource.incrementQuantity(id);
  }
}
