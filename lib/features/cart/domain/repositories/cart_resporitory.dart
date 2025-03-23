import 'package:ecommerce_assignment/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_assignment/features/products/domain/entiities/product.dart';

abstract class CartRepository {
  Future<void> addToCart(Product product);
  Future<void> removeFromCart(int productId);
  Future<List<CartItem>> getCartItems();
  Future<void> clearCart();
  Future<void> decrementQuantity(int id);
  Future<void> incrementQuantity(int id);
}
