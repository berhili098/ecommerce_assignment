import 'package:ecommerce_assignment/features/orders/presentation/state/order_cubit.dart';
import 'package:ecommerce_assignment/features/orders/presentation/state/order_state.dart';
import 'package:ecommerce_assignment/features/orders/presentation/widget/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  static const route = "/orders";

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrderCubit>().fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Orders")),
      body: SafeArea(
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state is OrderLoading || state is OrderInitial) {
              return Center(child: CircularProgressIndicator());
            } else if (state is OrderError) {
              return Center(child: Text(state.message));
            }

            final orders = (state as OrderLoaded).orders;

            if (orders.isEmpty) return Center(child: Text("No orders found"));

            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final order = state.orders[index];
                return OrderCard(order: order);
              },
            );
          },
        ),
      ),
    );
  }
}
