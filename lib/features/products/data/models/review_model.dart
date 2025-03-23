import 'package:ecommerce_assignment/features/products/domain/entiities/review.dart';
import 'package:hive/hive.dart';

part 'review_model.g.dart';

@HiveType(typeId: 4)
class ReviewModel extends HiveObject {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String userName;

  @HiveField(2)
  final String comment;

  @HiveField(3)
  final double rating;

  ReviewModel({
    required this.productId,
    required this.userName,
    required this.comment,
    required this.rating,
  });

  factory ReviewModel.fromEntity(Review review) {
    return ReviewModel(
      productId: review.productId,
      userName: review.userName,
      comment: review.comment,
      rating: review.rating,
    );
  }

  Review toEntity() {
    return Review(productId: productId, userName: userName, comment: comment, rating: rating);
  }
}
