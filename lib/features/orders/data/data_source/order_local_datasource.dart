import 'package:ecommerce_assignment/features/orders/data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

abstract class OrderDataSource {
  Future<void> placeOrder(OrderModel order);
  Future<List<OrderModel>> getOrders();
}

class OrderLocalDatasource implements OrderDataSource {
  final Box<OrderModel> orderBox;

  OrderLocalDatasource(this.orderBox);

  @override
  Future<List<OrderModel>> getOrders() async {
    return orderBox.values.toList();
  }

  @override
  Future<void> placeOrder(OrderModel order) async {
    try {
      await orderBox.put(order.id, order);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
