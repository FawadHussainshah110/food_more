import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:iconsax/iconsax.dart';
import 'shimmer.dart';

class PrimaryNetworkImage extends StatelessWidget {
  final String? url;
  final BoxFit fit;
  final double? height;
  final double? width;

  const PrimaryNetworkImage({required this.url, this.fit = BoxFit.cover, this.height, this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height ?? double.infinity,
      width: width,
      imageUrl: "$url",
      fit: fit,
      placeholder: (c, s) {
        return CustomShimmer(child: Container(color: Colors.grey[300]));
      },
      errorWidget: (c, s, o) {
        return Container(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: Center(child: Icon(Iconsax.image, size: 50.sp)),
        );
      },
    );
  }
}
