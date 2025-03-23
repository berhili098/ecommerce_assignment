import 'dart:convert';

import 'package:ecommerce_assignment/core/exceptions/api_exception.dart';
import 'package:ecommerce_assignment/features/products/data/models/product_model.dart';
import 'package:http/http.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDatasource implements ProductDataSource {
  final _baseUrl = "https://fakestoreapi.com";

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final res = await get(Uri.parse("$_baseUrl/products"));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body) as List;
        return data.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw ApiException("Failed to load products");
      }
    } catch (e) {
      throw ApiException("Something went wrong");
    }
  }
}
