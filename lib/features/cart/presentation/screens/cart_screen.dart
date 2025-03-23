import 'package:ecommerce_assignment/config/di/dependency_injection.dart';
import 'package:ecommerce_assignment/config/router/app_router.dart';
import 'package:ecommerce_assignment/core/overlays/dialogs.dart';
import 'package:ecommerce_assignment/core/widgets/button.dart';
import 'package:ecommerce_assignment/core/widgets/spacing.dart';
import 'package:ecommerce_assignment/features/cart/presentation/state/cart_cubit.dart';
import 'package:ecommerce_assignment/features/cart/presentation/widgets/cart_item.dart';
import 'package:ecommerce_assignment/features/orders/presentation/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const route = "/cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<CartCubit>().fetchCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return state is CartLoaded && state.items.isNotEmpty
                  ? IconButton(
                    icon: Icon(Icons.delete, size: 25.sp),
                    onPressed: () {
                      AppDialogs.showConfirmationDialog(
                        context,
                        "Are you sure you want to clear cart?",
                        () {
                          getIt<CartCubit>().clearCart();
                        },
                      );
                    },
                  )
                  : SizedBox();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            }

            final cartItems = (state as CartLoaded).items;
            if (cartItems.isEmpty) {
              return Center(child: Text("No items in cart"));
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      clipBehavior: Clip.none,
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = state.items[index];
                        return CartItemCard(cartItem: cartItem);
                      },
                      separatorBuilder: (context, index) => VerticalSpacing(10),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        Text(
                          "\$${state.totalPrice.toStringAsFixed(2)}",
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 2,
                          child: AppElevatedButton(
                            onPressed: () {
                              AppRouter.pushNamed(context, CheckoutScreen.route);
                            },
                            text: "Checkout",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
