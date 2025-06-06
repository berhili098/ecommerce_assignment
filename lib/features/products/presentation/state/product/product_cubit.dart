import 'package:ecommerce_assignment/config/di/dependency_injection.dart';
import 'package:ecommerce_assignment/core/overlays/toast.dart';
import 'package:ecommerce_assignment/core/utils/helpers/connection_handler.dart';
import 'package:ecommerce_assignment/features/products/domain/entiities/product.dart';
import 'package:ecommerce_assignment/features/products/domain/respositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_state.dart';

export 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _productRepository;
  List<Product> _products = [];

  bool get _connectedToInternet => getIt<ConnectionHandler>().connected;

  ProductCubit(this._productRepository) : super(ProductLoading());

  Future<void> fetchProducts() async {
    if (!_connectedToInternet) {
      AppToast.show("No internet connection");
      return;
    }

    emit(ProductLoading());

    // this is intentionally added to show shimmer effect
    await Future.delayed(Duration(seconds: 2));
    try {
      _products = await _productRepository.getProducts();
      emit(ProductLoaded(_products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      emit(ProductLoaded(_products));
      return;
    }
    final filteredProducts =
        _products
            .where((product) => product.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
    emit(ProductLoaded(filteredProducts));
  }
}
