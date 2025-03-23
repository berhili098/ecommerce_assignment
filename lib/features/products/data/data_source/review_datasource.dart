import 'package:ecommerce_assignment/core/exceptions/database_exceptions.dart';
import 'package:ecommerce_assignment/features/products/data/models/review_model.dart';
import 'package:hive/hive.dart';

abstract class ReviewDataSource {
  Future<void> addReview(ReviewModel review);
  Future<ReviewModel> getReview(int productId);
}

class ReviewLocalDataSource implements ReviewDataSource {
  final Box<ReviewModel> reviewBox;

  ReviewLocalDataSource(this.reviewBox);

  @override
  Future<void> addReview(ReviewModel review) async {
    await reviewBox.put(review.productId, review);
  }

  @override
  Future<ReviewModel> getReview(int productId) async {
    final review = reviewBox.get(productId);
    if (review == null) {
      throw ItemNotFoundException();
    }

    return review;
  }
}
