
import 'package:ecommerce_assignment/features/products/domain/entiities/review.dart';
import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();
  @override
  List<Object?> get props => [];
}

class ReviewLoading extends ReviewState {}
class ReviewAdded extends ReviewState {}
class ReviewLoaded extends ReviewState {
  final Review review;
  const ReviewLoaded(this.review);

  @override
  List<Object?> get props => [review];
}
class ReviewError extends ReviewState {
  final String message;
  const ReviewError(this.message);
  @override
  List<Object?> get props => [message];
}