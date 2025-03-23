import 'package:ecommerce_assignment/core/exceptions/cart_exceptions.dart';
import 'package:ecommerce_assignment/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_assignment/features/products/data/models/product_model.dart';
import 'package:hive/hive.dart';

abstract class CartDataSource {
  Future<void> addToCart(ProductModel product);
  Future<void> removeFromCart(int productId);
  Future<List<CartItemModel>> getCartItems();
  Future<CartItemModel> getCartItem(int productId);
  Future<void> clearCart();
  Future<void> decrementQuantity(int id);
  Future<void> incrementQuantity(int id);
}

class CartLocalDataSource implements CartDataSource {
  final Box<CartItemModel> cartBox;

  CartLocalDataSource(this.cartBox);

  @override
  Future<void> addToCart(ProductModel product) async {
    final cartItem = cartBox.get(product.id);
    if (cartItem != null) {
      throw CartItemAlreadyExistsException();
    } else {
      await cartBox.put(product.id, CartItemModel(product: product, quantity: 1));
    }
  }

  @override
  Future<List<CartItemModel>> getCartItems() async {
    return cartBox.values.toList();
  }

  @override
  Future<CartItemModel> getCartItem(int productId) {
    return Future.value(cartBox.get(productId));
  }

  @override
  Future<void> removeFromCart(int productId) async {
    await cartBox.delete(productId);
  }

  @override
  Future<void> clearCart() async {
    await cartBox.clear();
  }

  @override
  Future<void> decrementQuantity(int id) async {
    final cartItem = cartBox.get(id);
    if (cartItem != null) {
      if (cartItem.quantity > 1) {
        await cartBox.put(id, cartItem.copyWith(quantity: cartItem.quantity - 1));
      } else {
        await cartBox.delete(id);
      }
    }
  }

  @override
  Future<void> incrementQuantity(int id) async {
    final cartItem = cartBox.get(id);
    if (cartItem != null) {
      await cartBox.put(id, cartItem.copyWith(quantity: cartItem.quantity + 1));
    }
  }
}
