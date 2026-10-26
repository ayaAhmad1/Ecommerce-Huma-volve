import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareProductButton extends StatelessWidget {
  final String productId;

  const ShareProductButton({super.key, required this.productId});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final productLink =
            "https://project-d7ac0929-a1b6-4380-a76.web.app/products/$productId";
        final String shareMessage = "look at this product:$productLink";
        await SharePlus.instance.share(
          ShareParams(text: shareMessage, subject: 'check out this product'),
        );
      },
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.share, size: 18),
      ),
    );
  }
}
