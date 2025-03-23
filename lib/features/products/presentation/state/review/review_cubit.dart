import 'package:ecommerce_assignment/features/products/domain/entiities/review.dart';
import 'package:ecommerce_assignment/features/products/domain/respositories/review_repository.dart';
import 'package:ecommerce_assignment/features/products/presentation/state/review/review_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewRepository reviewRepository;

  ReviewCubit(this.reviewRepository) : super(ReviewLoading());

  Future<void> addReview(Review review) async {
    emit(ReviewLoading());
    try {
      await reviewRepository.addReview(review);
      emit(ReviewAdded());
      fetchReview(review.productId);
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }

  Future<void> fetchReview(int productId) async {
    emit(ReviewLoading());
    try {
      final review = await reviewRepository.getReview(productId);
      emit(ReviewLoaded(review));
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }
}
