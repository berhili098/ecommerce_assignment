import 'package:ecommerce_assignment/core/widgets/spacing.dart';
import 'package:ecommerce_assignment/features/main/presentation/main_screen.dart';
import 'package:flutter/material.dart';

class TabItemWidget extends StatelessWidget {
  const TabItemWidget({super.key, required this.tab, required this.isActive, required this.onTap});
  final NavigatorTab tab;
  final bool isActive;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: SafeArea(
          child: Column(
            key: ValueKey(isActive),
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                tab.icon,
                color:
                    isActive
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.secondary,
              ),
              if (isActive) ...[
                VerticalSpacing(5),
                Text(
                  tab.title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: Theme.of(context).primaryColor),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
