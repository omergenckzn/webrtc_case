// lib/core/global_widgets/custom_app_bar.dart
import 'package:auto_route/auto_route.dart';
import 'package:dating_app/core/assets/assets.gen.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    required this.title,
    this.action,
    this.canPop = true,
    super.key,
  });

  final String title;
  final Widget? action;
  final bool canPop;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: canPop
          ? Padding(
              padding: const EdgeInsets.only(left: 12),
              child: InkWell(
                onTap: () => context.router.maybePop(),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.1),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Assets.icons.arrowLeft.svg(),
                ),
              ),
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: action != null
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: action!,
              ),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
