import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const CustomAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.centerTitle = false,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.showBackButton = false,
    this.onBackPressed,
  }) : assert(title != null || titleWidget != null, 'Either title or titleWidget must be provided');

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: titleWidget ?? (title != null ? Text(title!) : null),
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading && !showBackButton,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.w),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : leading,
      actions: actions,
      titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: foregroundColor ?? Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Custom App Bar with gradient background
class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final Gradient gradient;
  final Color? foregroundColor;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  const GradientAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.leading,
    this.centerTitle = false,
    required this.gradient,
    this.foregroundColor = Colors.white,
    this.showBackButton = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: AppBar(
        title: titleWidget ?? (title != null ? Text(title!) : null),
        centerTitle: centerTitle,
        backgroundColor: Colors.transparent,
        foregroundColor: foregroundColor,
        elevation: 0,
        leading: showBackButton
            ? IconButton(
                icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.w),
                onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
              )
            : leading,
        actions: actions,
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: foregroundColor,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Custom App Bar with search functionality
class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onClearPressed;
  final Widget? leading;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final bool isSearchActive;
  final VoidCallback? onSearchToggle;

  const SearchAppBar({
    super.key,
    this.title,
    this.hintText = 'Search...',
    this.controller,
    this.onChanged,
    this.onSearchPressed,
    this.onClearPressed,
    this.leading,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.isSearchActive = false,
    this.onSearchToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading && !isSearchActive,
      leading: isSearchActive
          ? IconButton(
              icon: Icon(Icons.arrow_back, size: 24.w),
              onPressed: onSearchToggle,
            )
          : leading,
      title: isSearchActive
          ? TextField(
              controller: controller,
              onChanged: onChanged,
              autofocus: true,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.6),
                ),
              ),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            )
          : Text(title ?? ''),
      actions: isSearchActive
          ? [
              if (controller?.text.isNotEmpty == true)
                IconButton(
                  icon: Icon(Icons.clear, size: 24.w),
                  onPressed: () {
                    controller?.clear();
                    onClearPressed?.call();
                  },
                ),
              IconButton(
                icon: Icon(Icons.search, size: 24.w),
                onPressed: onSearchPressed,
              ),
            ]
          : [
              IconButton(
                icon: Icon(Icons.search, size: 24.w),
                onPressed: onSearchToggle,
              ),
              ...?actions,
            ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Custom App Bar with profile picture
class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final String? profileImageUrl;
  final Widget? profilePlaceholder;
  final List<Widget>? actions;
  final VoidCallback? onProfileTap;

  const ProfileAppBar({
    super.key,
    this.title,
    this.subtitle,
    this.profileImageUrl,
    this.profilePlaceholder,
    this.actions,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            onTap: onProfileTap,
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 1,
                ),
              ),
              child: ClipOval(
                child: profileImageUrl != null
                    ? Image.network(
                        profileImageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildProfilePlaceholder(context);
                        },
                      )
                    : profilePlaceholder ?? _buildProfilePlaceholder(context),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
      actions: actions,
    );
  }

  Widget _buildProfilePlaceholder(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.person,
        size: 24.w,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}