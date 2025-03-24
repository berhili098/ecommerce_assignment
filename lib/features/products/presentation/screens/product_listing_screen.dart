import 'package:ecommerce_assignment/config/di/dependency_injection.dart';
import 'package:ecommerce_assignment/core/widgets/form_field.dart';
import 'package:ecommerce_assignment/core/widgets/spacing.dart';
import 'package:ecommerce_assignment/features/products/presentation/state/product/product_cubit.dart';
import 'package:ecommerce_assignment/features/products/presentation/widgets/product_card.dart';
import 'package:ecommerce_assignment/features/products/presentation/widgets/products_loading_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  static const route = "/products";

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<ProductCubit>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Products"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              getIt<ProductCubit>().fetchProducts();
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return ProductsLoadingShimmer();
          }

          if (state is ProductError) {
            return Center(child: Text(state.message));
          }

          final products = (state as ProductLoaded).products;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                VerticalSpacing(16),
                AppFormField(
                  hintText: "Search products",
                  onChanged: (query) {
                    getIt<ProductCubit>().searchProducts(query);
                  },
                ),
                VerticalSpacing(8),
                products.isEmpty
                    ? Center(child: Text("No products available"))
                    : Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.only(top: 8.h),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ProductCard(product: product);
                        },
                      ),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
