import 'package:ecommerce_assignment/core/exceptions/cart_exceptions.dart';
import 'package:ecommerce_assignment/core/overlays/toast.dart';
import 'package:ecommerce_assignment/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_assignment/features/cart/domain/repositories/cart_resporitory.dart';
import 'package:ecommerce_assignment/features/products/domain/entiities/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepository cartRepository;

  CartCubit(this.cartRepository) : super(CartLoading());

  Future<void> fetchCartItems() async {
    emit(CartLoading());
    try {
      final cartItems = await cartRepository.getCartItems();
      emit(CartLoaded(cartItems));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> addToCart(Product product) async {
    emit(CartLoading());
    try {
      await cartRepository.addToCart(product);
      AppToast.show('Product added to cart');
      fetchCartItems();
    } on CartItemAlreadyExistsException {
      AppToast.show('Product already in cart');
      fetchCartItems();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> removeFromCart(int productId) async {
    emit(CartLoading());
    try {
      await cartRepository.removeFromCart(productId);
      AppToast.show('Product removed from cart');
      fetchCartItems();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> clearCart() async {
    emit(CartLoading());
    try {
      await cartRepository.clearCart();
      emit(CartLoaded([]));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> decrementQuantity(int id) async {
    try {
      await cartRepository.decrementQuantity(id);
      fetchCartItems();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> incrementQuantity(int id) async {
    try {
      await cartRepository.incrementQuantity(id);
      fetchCartItems();
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
