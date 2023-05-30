import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:waffarha_flutter_challenge/utils/values_manager.dart';

/// A custom widget for displaying an image with a border radius and caching support.
class ImageWithBorderRadius extends StatelessWidget {
  /// The URL of the image to display.
  final String imageUrl;

  /// The height of the image.
  double? height;

  /// The width of the image.
  double? width;

  ImageWithBorderRadius({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.s12),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height,
        width: width,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.black12,
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.black12,
          child: const Icon(
            Icons.error,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
