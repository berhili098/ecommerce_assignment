import 'package:ecommerce_assignment/core/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFormField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final bool? multiline;
  final Function(String)? onChanged;

  const AppFormField({
    super.key,
    this.hintText = "",
    this.labelText = "",
    this.validator,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.multiline = false,
    this.onChanged,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  bool? _isObscure;

  @override
  void initState() {
    super.initState();

    if (widget.obscureText) {
      _isObscure = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText.isNotEmpty) ...[
          Text(widget.labelText, style: Theme.of(context).textTheme.bodySmall),
          VerticalSpacing(10),
        ],
        TextFormField(
          readOnly: widget.readOnly,
          controller: widget.controller,
          cursorColor: Theme.of(context).colorScheme.secondary,
          keyboardType: widget.keyboardType,
          obscureText: _isObscure ?? false,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          maxLines: widget.multiline! ? null : 1,
          minLines: widget.multiline! ? 5 : 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.5),
            ),
            fillColor: Theme.of(context).colorScheme.tertiary,
            filled: true,
            suffixIcon:
                widget.obscureText
                    ? IconButton(
                      icon: Icon(
                        _isObscure! ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure!;
                        });
                      },
                    )
                    : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error.withValues(alpha: 0.1),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
