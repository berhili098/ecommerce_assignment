import 'package:ecommerce_assignment/features/products/domain/entiities/review.dart';

abstract class ReviewRepository {
  Future<void> addReview(Review review);
  Future<Review> getReview(int productId);
}
