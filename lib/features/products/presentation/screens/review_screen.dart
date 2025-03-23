import 'package:ecommerce_assignment/core/widgets/button.dart';
import 'package:ecommerce_assignment/core/widgets/form_field.dart';
import 'package:ecommerce_assignment/core/widgets/spacing.dart';
import 'package:ecommerce_assignment/features/products/domain/entiities/review.dart';
import 'package:ecommerce_assignment/features/products/presentation/state/review/review_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewInputScreen extends StatefulWidget {
  final int productId;
  const ReviewInputScreen({super.key, required this.productId});

  static const route = "/add-review";

  @override
  State<ReviewInputScreen> createState() => _ReviewInputScreenState();
}

class _ReviewInputScreenState extends State<ReviewInputScreen> {
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 5.0;

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _submitReview() {
    if (_reviewController.text.isEmpty) return;
    final review = Review(
      productId: widget.productId,
      userName: "User",
      comment: _reviewController.text,
      rating: _rating,
    );
    context.read<ReviewCubit>().addReview(review);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Write a Review")),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Your Review",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            VerticalSpacing(10),
            AppFormField(
              controller: _reviewController,
              hintText: "Write your review",
              multiline: true,
            ),
            VerticalSpacing(20),
            Text(
              "Rating",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            VerticalSpacing(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1.0;
                    });
                  },
                ),
              ),
            ),
            VerticalSpacing(20),
            AppElevatedButton(onPressed: _submitReview, text: "Submit Review"),
          ],
        ),
      ),
    );
  }
}
