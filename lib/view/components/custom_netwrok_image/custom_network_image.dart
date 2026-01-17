import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final Border? border;
  final BorderRadius? borderRadius;
  final BoxShape boxShape;
  final Color? backgroundColor;
  final BoxFit? fit;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.border,
    this.borderRadius,
    this.boxShape = BoxShape.rectangle,
    this.backgroundColor,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: border,
        shape: boxShape,
        color: backgroundColor,
        borderRadius: boxShape == BoxShape.circle ? null : borderRadius,
      ),
      child: boxShape == BoxShape.circle
          ? ClipOval(child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit ?? (boxShape == BoxShape.circle ? BoxFit.cover : BoxFit.fitWidth),
        placeholder: (context, url) => Container(
          color: Colors.grey[200],
          child: const SizedBox.shrink(),
        ),
        errorWidget: (context, url, error) => Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey[400],
          child: const Center(
            child: Icon(Icons.error, color: Colors.black, size: 20),
          ),
        ),
      ))
          : ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child:  CachedNetworkImage(
          imageUrl: imageUrl,
          fit: fit ?? (boxShape == BoxShape.circle ? BoxFit.cover : BoxFit.fitWidth),
          placeholder: (context, url) => Container(
            color: Colors.grey[200],
            child: const SizedBox.shrink(),
          ),
          errorWidget: (context, url, error) => Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[400],
            child: const Center(
              child: Icon(Icons.error, color: Colors.black, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}

