import 'package:ecommerce_assignment/core/widgets/spacing.dart';
import 'package:ecommerce_assignment/features/orders/domain/entities/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order ID: ${order.id}", style: Theme.of(context).textTheme.bodyMedium),
            VerticalSpacing(10),
            Text(
              "Total Price: \$${order.totalPrice.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text("Status: ${order.status.name}", style: Theme.of(context).textTheme.bodyMedium),
            Text(
              "Date: ${DateFormat.yMMMd().format(order.orderDate)}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            VerticalSpacing(10),
            Text("Items:", style: Theme.of(context).textTheme.bodyMedium),
            ...order.items.map((item) => Text("- ${item.product.title} x${item.quantity}")),
          ],
        ),
      ),
    );
  }
}
