import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:ecommerce_assignment/config/di/dependency_injection.dart';
import 'package:ecommerce_assignment/config/router/app_router.dart';
import 'package:ecommerce_assignment/features/cart/domain/entities/cart_item.dart';
import 'package:ecommerce_assignment/features/cart/presentation/state/cart_cubit.dart';
import 'package:ecommerce_assignment/features/products/presentation/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemCard extends StatefulWidget {
  final CartItem cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> with SingleTickerProviderStateMixin {
  double _offset = 0.0;

  @override
  void initState() {
    super.initState();

    // Add animation to the first item in the cart
    final cart = getIt<CartCubit>().state as CartLoaded;
    if (cart.items.indexOf(widget.cartItem) == 0) {
      Future.delayed(Duration(milliseconds: 800), () {
        if (mounted) {
          setState(() => _offset = -35.0);
          Future.delayed(Duration(milliseconds: 500), () {
            if (mounted) setState(() => _offset = 0.0);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.cartItem.product.id),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.error,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        child: Icon(Icons.delete, color: Colors.white, size: 20.sp),
      ),
      onDismissed: (_) {
        getIt<CartCubit>().removeFromCart(widget.cartItem.product.id);
      },
      child: ClipRRect(
        child: Card(
          margin: EdgeInsets.zero,
          color: Theme.of(context).colorScheme.error,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            transform: Matrix4.translationValues(_offset, 0, 0),
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              tileColor: Theme.of(context).cardColor,
              contentPadding: EdgeInsets.all(8.w),
              leading: GestureDetector(
                onTap: () {
                  AppRouter.pushNamed(
                    context,
                    ProductDetailScreen.route,
                    arguments: widget.cartItem.product,
                  );
                },
                child: Hero(
                  tag: widget.cartItem.product.image,
                  child: CacheNetworkImagePlus(
                    imageUrl: widget.cartItem.product.image,
                    boxFit: BoxFit.cover,
                    width: 50.w,
                    height: 50.h,
                  ),
                ),
              ),
              title: Text(
                widget.cartItem.product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed:
                            () => getIt<CartCubit>().decrementQuantity(widget.cartItem.product.id),
                        style: ButtonStyle(
                          foregroundColor: WidgetStateProperty.all<Color>(
                            Theme.of(context).iconTheme.color!,
                          ),
                        ),
                      ),
                      Text(
                        widget.cartItem.quantity.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed:
                            () => getIt<CartCubit>().incrementQuantity(widget.cartItem.product.id),
                        style: ButtonStyle(
                          foregroundColor: WidgetStateProperty.all<Color>(
                            Theme.of(context).iconTheme.color!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
