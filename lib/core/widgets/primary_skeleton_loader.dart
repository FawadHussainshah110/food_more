// ignore_for_file: deprecated_member_use

import 'package:food_app_task/core/widgets/shimmer.dart';
import 'package:food_app_task/imports.dart';

class PrimarySkeletonLoader extends StatelessWidget {
  final bool showHeaderImage;
  final double? headerImageHeight;
  final bool showTitle;
  final double? titleWidth;
  final bool showSubtitle;
  final double? subtitleWidth;
  final bool showDescription;
  final double? descriptionHeight;
  final bool showServiceTags;
  final int serviceTagsCount;
  final bool showActionButton;
  final double? containerHeight;
  final bool hasTopRadius;
  final List<ShimmerItem>? customItems;

  const PrimarySkeletonLoader({
    super.key,
    this.showHeaderImage = true,
    this.headerImageHeight,
    this.showTitle = true,
    this.titleWidth,
    this.showSubtitle = true,
    this.subtitleWidth,
    this.showDescription = true,
    this.descriptionHeight,
    this.showServiceTags = true,
    this.serviceTagsCount = 5,
    this.showActionButton = true,
    this.containerHeight,
    this.hasTopRadius = true,
    this.customItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight ?? Get.height * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: hasTopRadius
            ? BorderRadius.vertical(top: Radius.circular(radiusDefault))
            : BorderRadius.circular(radiusDefault),
      ),
      child: ListView(
        children: [
          // Header Image
          if (showHeaderImage) _buildHeaderImage(context),

          Padding(
            padding: paddingDefault,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                if (showTitle) ...[
                  _buildShimmerBox(height: 20.sp, width: titleWidth ?? 150.sp, context: context),
                  SizedBox(height: spacingMedium),
                ],

                // Subtitle
                if (showSubtitle) ...[
                  _buildShimmerBox(height: 15.sp, width: subtitleWidth ?? 200.sp, context: context),
                  SizedBox(height: spacingMedium),
                ],

                // Description
                if (showDescription) ...[
                  _buildShimmerBox(height: descriptionHeight ?? 60.sp, width: double.infinity, context: context),
                  SizedBox(height: spacingLarge),
                ],

                // Custom Items
                if (customItems != null) ...[
                  ...customItems!.map(
                    (item) => Column(
                      children: [
                        _buildShimmerBox(
                          height: item.height,
                          width: item.width,
                          context: context,
                          borderRadius: item.borderRadius,
                        ),
                        SizedBox(height: item.spacing ?? spacingMedium),
                      ],
                    ),
                  ),
                ],

                // Service Tags
                if (showServiceTags) ...[
                  _buildShimmerBox(height: 20.sp, width: 100.sp, context: context),
                  SizedBox(height: spacingMedium),
                  Wrap(
                    spacing: 8.sp,
                    runSpacing: 8.sp,
                    children: List.generate(
                      serviceTagsCount,
                      (index) => _buildShimmerBox(
                        height: 30.sp,
                        width: 80.sp,
                        context: context,
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                    ),
                  ),
                  SizedBox(height: spacingExtraLarge),
                ],

                // Action Button
                if (showActionButton) ...[
                  _buildShimmerBox(
                    height: 45.sp,
                    width: double.infinity,
                    context: context,
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  SizedBox(height: spacingExtraLarge),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderImage(BuildContext context) {
    return CustomShimmer(
      child: ClipRRect(
        borderRadius: hasTopRadius ? BorderRadius.vertical(top: Radius.circular(radiusDefault)) : BorderRadius.zero,
        child: Container(height: headerImageHeight ?? 200.sp, width: double.infinity, color: Colors.white),
      ),
    );
  }

  Widget _buildShimmerBox({
    required double height,
    required double width,
    required BuildContext context,
    BorderRadius? borderRadius,
  }) {
    return CustomShimmer(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius ?? BorderRadius.circular(4.sp)),
      ),
    );
  }
}

class ShimmerItem {
  final double height;
  final double width;
  final BorderRadius? borderRadius;
  final double? spacing;

  const ShimmerItem({required this.height, required this.width, this.borderRadius, this.spacing});
}

// Predefined configurations for common use cases
class ShimmerConfigs {
  // Profile Screen Configuration
  static PrimarySkeletonLoader profileScreen() {
    return const PrimarySkeletonLoader(
      showHeaderImage: false,
      showDescription: false,
      showServiceTags: false,
      showActionButton: false,
      containerHeight: null,
      hasTopRadius: false,
      customItems: [
        ShimmerItem(height: 90, width: 90), // Profile avatar
        ShimmerItem(height: 20, width: 150), // Name
        ShimmerItem(height: 16, width: 200), // Email
        ShimmerItem(height: 16, width: 140), // Phone
      ],
    );
  }

  // Card List Configuration
  static PrimarySkeletonLoader cardList({int itemCount = 3}) {
    return PrimarySkeletonLoader(
      showHeaderImage: false,
      showServiceTags: false,
      showActionButton: false,
      containerHeight: null,
      hasTopRadius: false,
      customItems: List.generate(
        itemCount,
        (index) => const ShimmerItem(height: 80, width: double.infinity, spacing: 16),
      ),
    );
  }

  // Service Details Configuration
  static PrimarySkeletonLoader serviceDetails() {
    return const PrimarySkeletonLoader(
      showHeaderImage: true,
      headerImageHeight: 250,
      showTitle: true,
      titleWidth: 180,
      showSubtitle: true,
      subtitleWidth: 120,
      showDescription: true,
      descriptionHeight: 80,
      showServiceTags: true,
      serviceTagsCount: 4,
      showActionButton: true,
    );
  }

  // Simple List Configuration
  static PrimarySkeletonLoader simpleList({int itemCount = 5}) {
    return PrimarySkeletonLoader(
      showHeaderImage: false,
      showTitle: false,
      showSubtitle: false,
      showDescription: false,
      showServiceTags: false,
      showActionButton: false,
      containerHeight: null,
      hasTopRadius: false,
      customItems: List.generate(
        itemCount,
        (index) => const ShimmerItem(height: 60, width: double.infinity, spacing: 12),
      ),
    );
  }
}
