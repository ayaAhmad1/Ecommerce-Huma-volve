import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final List<String> imageUrls;
  final BoxFit fit;
  final double errorIconSize;

  const ProductImage({
    super.key,
    required this.imageUrls,
    this.fit = BoxFit.cover,
    this.errorIconSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    return _buildImage(0);
  }

  Widget _buildImage(int index) {
    if (index >= imageUrls.length) {
      return Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: errorIconSize,
          color: Colors.grey,
        ),
      );
    }

    final url = imageUrls[index].trim();

    if (url.isEmpty) {
      return _buildImage(index + 1);
    }

    return Image.network(
      url,
      fit: fit,
      width: double.infinity,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;

        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Failed image URL: $url');
        debugPrint('Image error: $error');

        return _buildImage(index + 1);
      },
    );
  }
}
