import 'package:ecommerce_assignment/features/orders/domain/entities/order.dart';

abstract class OrderRepository {
  Future<void> placeOrder(Order order);
  Future<List<Order>> getOrders();
}
