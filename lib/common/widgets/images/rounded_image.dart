import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:edtech/common/widgets/shimmer/shimmer.dart';
import 'package:edtech/utils/constants/colors.dart';
import 'package:edtech/utils/constants/image_strings.dart';
import 'package:edtech/utils/constants/sizes.dart';
import 'package:edtech/utils/helpers/helper_functions.dart';

class KRoundedImage extends StatelessWidget {
  const KRoundedImage({
    super.key,
    this.width = 56,
    this.height = 56,
    required this.imageUrl,
    this.border,
    this.backgroundColor,
    this.overlayColor,
    this.fit = BoxFit.cover,
    this.padding,
    this.isNetworkImage = true,
    this.applyImageRadius = true,
    this.onPressed,
    this.borderRadius = KSizes.md,
  });

  final double? width, height;
  final String imageUrl;
  final BoxBorder? border;
  final Color? backgroundColor, overlayColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage, applyImageRadius;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor ??
              (KHelperFunctions.isDarkMode(context)
                  ? KColors.dark
                  : KColors.white),
          border: border,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImage
              ? CachedNetworkImage(
                  fit: fit,
                  imageUrl: imageUrl,
                  color: overlayColor,
                  progressIndicatorBuilder: (context, url, progress) =>
                      KShimmerEffect(
                          width: 55, hight: 55, radius: borderRadius),
                  errorWidget: (context, url, error) => Image.asset(
                  KImages.errorImage,
                  fit: fit,
                 
                ),
                )
              : Image.asset(
                  imageUrl,
                  fit: fit,
                  color: overlayColor,
                ),
        ),
      ),
    );
  }
}
/*
ClipRRect(
         
            child: Image(
              image: isNetworkImage
                  ? NetworkImage(imageUrl)
                  : AssetImage(imageUrl) as ImageProvider,
              fit: fit,
            ))

*/