import 'dart:math';

import 'package:ecommerce_assignment/config/di/dependency_injection.dart';
import 'package:ecommerce_assignment/config/router/app_router.dart';
import 'package:ecommerce_assignment/core/enums/order_status.dart';
import 'package:ecommerce_assignment/core/enums/payment_method.dart';
import 'package:ecommerce_assignment/core/overlays/toast.dart';
import 'package:ecommerce_assignment/core/widgets/button.dart';
import 'package:ecommerce_assignment/core/widgets/spacing.dart';
import 'package:ecommerce_assignment/features/auth/presentation/state/auth_cubit.dart';
import 'package:ecommerce_assignment/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_assignment/features/cart/presentation/state/cart_cubit.dart';
import 'package:ecommerce_assignment/features/orders/domain/entities/order.dart';
import 'package:ecommerce_assignment/features/orders/presentation/state/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  static const route = "/checkout";

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final ValueNotifier<PaymentMethods> _paymentMethodNotifier = ValueNotifier(PaymentMethods.cash);

  @override
  void dispose() {
    _paymentMethodNotifier.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    final cartState = context.read<CartCubit>().state;
    if (cartState is! CartLoaded || cartState.items.isEmpty) {
      AppToast.show("Cart is empty");
      return;
    }

    final order = Order(
      id: Uuid().v4(),
      items: List<CartItem>.from(cartState.items),
      totalPrice: cartState.totalPrice + 5,
      userId: (getIt<AuthCubit>().state as AuthAuthenticated).user.id,
      status: OrderStatus.values[Random().nextInt(OrderStatus.values.length)],
      orderDate: DateTime.now(),
    );

    await getIt<OrderCubit>().placeOrder(order);
    getIt<CartCubit>().clearCart();

    AppToast.show("Order placed successfully");

    AppRouter.popRoute(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Sub Total", style: Theme.of(context).textTheme.bodyLarge),
                  Spacer(),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      if (state is CartLoaded) {
                        return Text(
                          "\$${state.totalPrice.toStringAsFixed(2)}",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ],
              ),
              VerticalSpacing(10),
              Row(
                children: [
                  Text("Shipping", style: Theme.of(context).textTheme.bodyLarge),
                  Spacer(),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      if (state is CartLoaded) {
                        return Text(
                          "\$ 5.00",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ],
              ),
              VerticalSpacing(10),
              Divider(),
              VerticalSpacing(10),
              Row(
                children: [
                  Text("Total", style: Theme.of(context).textTheme.bodyLarge),
                  Spacer(),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      if (state is CartLoaded) {
                        return Text(
                          "\$${(state.totalPrice + 5).toStringAsFixed(2)}",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                ],
              ),
              VerticalSpacing(20),
              Text(
                "Shipping Address",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                (getIt<AuthCubit>().state as AuthAuthenticated).user.address,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              VerticalSpacing(20),
              Text(
                "Payment Method",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              ValueListenableBuilder<PaymentMethods>(
                valueListenable: _paymentMethodNotifier,
                builder: (context, paymentMethod, child) {
                  return Column(
                    children:
                        PaymentMethods.values
                            .map(
                              (method) => RadioListTile<PaymentMethods>(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  method.name,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                activeColor: Theme.of(context).primaryColor,

                                value: method,
                                groupValue: paymentMethod,
                                onChanged: (value) {
                                  _paymentMethodNotifier.value = value!;
                                },
                              ),
                            )
                            .toList(),
                  );
                },
              ),
              VerticalSpacing(20),
              Text(
                "Note: Your order will be delivered within 3-5 business days. For more information, please contact our customer service.",
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.justify,
              ),
              Spacer(),
              AppElevatedButton(onPressed: _placeOrder, text: "Place Order"),
            ],
          ),
        ),
      ),
    );
  }
}
