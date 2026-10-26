import 'package:commerce_app/features/details/screens/product_details_screen.dart';
import 'package:commerce_app/features/details/screens/shared_product_screen.dart';
import 'package:commerce_app/features/home/domain/entities/home_product_entity.dart';
import 'package:commerce_app/features/splash/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final appRouting = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/products/:id',
      builder: (context, state) {
        final product = state.extra;
        if (product is HomeProductEntity) {
          return ProductDetailsScreen(product: product);
        }
        return SharedProductScreen(
          productId: state.pathParameters['id']!,
        );
      },
    ),
  ],
);
