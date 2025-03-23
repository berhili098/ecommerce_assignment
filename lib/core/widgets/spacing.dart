import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing(this.height, {super.key});
  final int height;

  @override
  Widget build(BuildContext context) => SizedBox(height: height.h);
}

class HorizontalSpacing extends StatelessWidget {
  const HorizontalSpacing(this.width, {super.key});
  final int width;

  @override
  Widget build(BuildContext context) => SizedBox(width: width.w);
}
