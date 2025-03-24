import 'package:ecommerce_assignment/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_assignment/features/products/data/models/product_model.dart';
import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 1)
class CartItemModel {
  @HiveField(0)
  final ProductModel product;

  @HiveField(1)
  final int quantity;

  CartItemModel({required this.product, required this.quantity});

  CartItemModel copyWith({ProductModel? product, int? quantity}) {
    return CartItemModel(product: product ?? this.product, quantity: quantity ?? this.quantity);
  }

  factory CartItemModel.fromEntity(CartItem item) {
    return CartItemModel(product: ProductModel.fromEntity(item.product), quantity: item.quantity);
  }

  CartItem toEntity() {
    return CartItem(product: product.toEntity(), quantity: quantity);
  }
}
