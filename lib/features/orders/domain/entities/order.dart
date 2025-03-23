import 'package:ecommerce_assignment/core/enums/order_status.dart';
import 'package:ecommerce_assignment/features/cart/domain/entities/cart_item.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double totalPrice;
  final String userId;
  final OrderStatus status;
  final DateTime orderDate;

  Order({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.userId,
    required this.status,
    required this.orderDate,
  });
}
