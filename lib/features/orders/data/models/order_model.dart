import 'package:ecommerce_assignment/core/enums/order_status.dart';
import 'package:ecommerce_assignment/features/cart/data/models/cart_item_model.dart';
import 'package:ecommerce_assignment/features/orders/domain/entities/order.dart';
import 'package:hive/hive.dart';

part 'order_model.g.dart';

@HiveType(typeId: 2)
class OrderModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<CartItemModel> items;

  @HiveField(2)
  final double totalPrice;

  @HiveField(3)
  final String userId;

  @HiveField(4)
  final OrderStatus status;

  @HiveField(5)
  final DateTime orderDate;

  OrderModel({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.userId,
    required this.status,
    required this.orderDate,
  });

  factory OrderModel.fromEntity(Order order) {
    return OrderModel(
      id: order.id,
      items: order.items.map((item) => CartItemModel.fromEntity(item)).toList(),
      totalPrice: order.totalPrice,
      userId: order.userId,
      status: order.status,
      orderDate: order.orderDate,
    );
  }

  Order toEntity() {
    return Order(
      id: id,
      items: items.map((item) => item.toEntity()).toList(),
      totalPrice: totalPrice,
      userId: userId,
      status: status,
      orderDate: orderDate,
    );
  }
}
