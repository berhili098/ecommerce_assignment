import 'package:ecommerce_assignment/features/orders/domain/entities/order.dart';
import 'package:ecommerce_assignment/features/orders/domain/repositories/order_repository.dart';
import 'package:ecommerce_assignment/features/orders/presentation/state/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository orderRepository;

  OrderCubit(this.orderRepository) : super(OrderInitial());

  Future<void> placeOrder(Order order) async {
    emit(OrderLoading());
    try {
      await orderRepository.placeOrder(order);
      emit(OrderPlaced());
      fetchOrders();
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> fetchOrders() async {
    emit(OrderLoading());
    try {
      final orders = await orderRepository.getOrders();
      debugPrint("Orders fetched: $orders");
      emit(OrderLoaded(orders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
