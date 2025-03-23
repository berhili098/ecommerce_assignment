import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:ecommerce_assignment/config/di/dependency_injection.dart';
import 'package:ecommerce_assignment/config/router/app_router.dart';
import 'package:ecommerce_assignment/core/widgets/button.dart';
import 'package:ecommerce_assignment/core/widgets/spacing.dart';
import 'package:ecommerce_assignment/features/cart/presentation/state/cart_cubit.dart';
import 'package:ecommerce_assignment/features/products/domain/entiities/product.dart';
import 'package:ecommerce_assignment/features/products/presentation/screens/review_screen.dart';
import 'package:ecommerce_assignment/features/products/presentation/state/review/review_cubit.dart';
import 'package:ecommerce_assignment/features/products/presentation/state/review/review_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  static const route = "/product-detail";

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<ReviewCubit>().fetchReview(widget.product.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.title, overflow: TextOverflow.clip)),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            final isAlreadyInCart =
                state is CartLoaded && state.items.any((i) => i.product == widget.product);
            return AppElevatedButton(
              text: isAlreadyInCart ? "Remove from Cart" : "Add to Cart",
              loading: state is CartLoading,
              onPressed: () {
                isAlreadyInCart
                    ? getIt<CartCubit>().removeFromCart(widget.product.id)
                    : getIt<CartCubit>().addToCart(widget.product);
              },
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Hero(
                    tag: widget.product.image,
                    child: CacheNetworkImagePlus(
                      imageUrl: widget.product.image,
                      boxFit: BoxFit.cover,
                      height: 250.h,
                    ),
                  ),
                ),
                VerticalSpacing(16),
                Text(
                  widget.product.title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                VerticalSpacing(8),
                Text(
                  "\$${widget.product.price.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                VerticalSpacing(8),
                Text(
                  widget.product.description,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.justify,
                ),
                VerticalSpacing(8),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Review",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        BlocBuilder<ReviewCubit, ReviewState>(
                          builder: (context, state) {
                            if (state is ReviewLoaded) {
                              return state.review.productId == widget.product.id
                                  ? Text(
                                    "${state.review.rating.toStringAsFixed(0)} ⭐",
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                  : SizedBox();
                            } else {
                              return AppTextButton(
                                text: "Write a review",
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  AppRouter.pushNamed(
                                    context,
                                    ReviewInputScreen.route,
                                    arguments: widget.product.id,
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
