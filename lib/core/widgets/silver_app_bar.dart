// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:food_app_task/imports.dart';

class CustomSliverAppBar extends StatefulWidget {
  final double? expandedHeight;
  final Widget? leading;
  final List<Widget>? actions;
  final String? backgroundImageUrl;
  final VoidCallback? onBackPressed;
  final VoidCallback? onActionPressed;
  final double backgroundOpacity;
  bool? isFavorite;
  bool? centerTitle;

  Widget? background;
  Widget? title;

  CustomSliverAppBar({
    super.key,
    this.expandedHeight,
    this.backgroundImageUrl,
    this.leading,
    this.actions,
    this.onBackPressed,
    this.onActionPressed,
    this.backgroundOpacity = 0.3,
    this.isFavorite = false,
    this.background,
    this.title,
    this.centerTitle = true,
  });

  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: widget.expandedHeight ?? 250.sp,
      pinned: true,
      floating: false,
      leading: widget.leading ?? const SliverActionButton(icon: Icons.arrow_back),
      actions: widget.actions,
      centerTitle: widget.centerTitle,
      title: widget.title,
      flexibleSpace: FlexibleSpaceBar(background: widget.background),
    );
  }
}

class SliverActionButton extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final double? backgroundOpacity;
  final Color? color;
  final IconData icon;

  const SliverActionButton({
    super.key,
    this.onBackPressed,
    this.backgroundOpacity = 0.3,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: paddingSmall,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(backgroundOpacity!),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon),
        color: color ?? Theme.of(context).iconTheme.color,
        onPressed: () {
          if (onBackPressed != null) {
            onBackPressed!();
            return;
          }
          pop();
        },
      ),
    );
  }
}
