import 'package:ecommerce_assignment/features/products/domain/entiities/product.dart';
import 'package:equatable/equatable.dart';

class CartItem with EquatableMixin {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity});

  @override
  List<Object?> get props => [product, quantity];
}
