import 'package:ecommerce_assignment/features/products/data/data_source/review_datasource.dart';
import 'package:ecommerce_assignment/features/products/data/models/review_model.dart';
import 'package:ecommerce_assignment/features/products/domain/entiities/review.dart';
import 'package:ecommerce_assignment/features/products/domain/respositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewDataSource dataSource;

  ReviewRepositoryImpl(this.dataSource);

  @override
  Future<void> addReview(Review review) async {
    await dataSource.addReview(ReviewModel.fromEntity(review));
  }

  @override
  Future<Review> getReview(int productId) async {
    final review = await dataSource.getReview(productId);
    return review.toEntity();
  }
}
