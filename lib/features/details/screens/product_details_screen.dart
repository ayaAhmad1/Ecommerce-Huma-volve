import 'package:commerce_app/core/widgets/product_image.dart';
import 'package:commerce_app/features/home/domain/entities/home_product_entity.dart';
import 'package:flutter/material.dart';

import '../../../core/theme.dart';
import '../../../core/widgets/primary_button.dart';
import '../widgets/share_product_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  final HomeProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: AppTheme.background,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new, size: 16),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              ShareProductButton(productId: product.id.toString()),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.favorite_border, size: 18),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'product-${product.id}',
                child: ProductImage(
                  imageUrls: product.images,
                  fit: BoxFit.cover,
                  errorIconSize: 48,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              transform: Matrix4.translationValues(0, -32, 0),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.title,
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(fontSize: 28, height: 1.2),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '\$${(product.price).toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(color: AppTheme.primary, fontSize: 24),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Category
                    if (product.category?.name != null) ...[
                      Text(
                        'Category',
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.category!.name,
                        style: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Description
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description.isNotEmpty == true
                          ? product.description
                          : 'No description available.',
                      style: Theme.of(context).textTheme.bodyMedium
                          ?.copyWith(height: 1.6, fontSize: 16),
                    ),

                    const SizedBox(height: 32),

                    // Add to cart
                    PrimaryButton(
                      text: 'Add to Cart',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.title} added to cart'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: AppTheme.primary,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
