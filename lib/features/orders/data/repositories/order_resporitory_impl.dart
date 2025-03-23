import 'package:ecommerce_assignment/features/orders/data/data_source/order_local_datasource.dart';
import 'package:ecommerce_assignment/features/orders/data/models/order_model.dart';
import 'package:ecommerce_assignment/features/orders/domain/entities/order.dart';
import 'package:ecommerce_assignment/features/orders/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderDataSource dataSource;

  OrderRepositoryImpl(this.dataSource);

  @override
  Future<List<Order>> getOrders() async {
    final orders = await dataSource.getOrders();
    return orders.map((order) => order.toEntity()).toList();
  }

  @override
  Future<void> placeOrder(Order order) async {
    await dataSource.placeOrder(OrderModel.fromEntity(order));
  }
}
