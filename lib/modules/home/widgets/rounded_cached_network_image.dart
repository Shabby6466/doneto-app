import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundedCacheImage extends StatelessWidget {
  /// The URL or file path of your image.
  final String imageUrl;

  /// The asset to show when [imageUrl] is empty or fails to load.
  final String placeholderAsset;

  /// Outer white container size
  final double width, height;

  /// How the image should be fit
  final BoxFit fit;

  /// Border radius for the container & clipping
  final BorderRadius borderRadius;

  const RoundedCacheImage({
    super.key,
    required this.imageUrl,
    required this.placeholderAsset,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    required this.borderRadius,
  });

  bool get _isNetwork => imageUrl.startsWith('http');

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    if (imageUrl.isEmpty) {
      return Image.asset(
        placeholderAsset,
        fit: fit,
        width: width,
        height: height,
      );
    }

    if (_isNetwork) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        width: width,
        height: height,
        placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
        errorWidget: (_, __, ___) => Image.asset(
          placeholderAsset,
          fit: fit,
          width: width,
          height: height,
        ),
      );
    }

    // must be a local file path
    return Image.file(
      File(imageUrl),
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (_, __, ___) => Image.asset(
        placeholderAsset,
        fit: fit,
        width: width,
        height: height,
      ),
    );
  }
}
