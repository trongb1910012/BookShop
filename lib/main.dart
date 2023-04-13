import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/ui/auth/auth_manager.dart';
import 'package:myapp/ui/manager/cart__manager.dart';
import 'package:myapp/ui/manager/order_manager.dart';
import 'package:myapp/ui/screens/detail_product_screen.dart';
import 'package:myapp/ui/screens/home_page.dart';
import 'package:myapp/ui/screens/orders_screen.dart';
import 'screens.dart';
import 'package:provider/provider.dart';
import './ui/manager/product_manager.dart';
import 'ui/screens/edit_product.dart';
import 'ui/screens/user_products_screen.dart';
import 'ui/splash_screen.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthManager(),
          ),
          ChangeNotifierProxyProvider<AuthManager, ProductManager>(
              create: (ctx) => ProductManager(),
              update: (ctx, authManager, productsmanager) {
                productsmanager!.authToken = authManager.authToken;
                return productsmanager;
              }),
          ChangeNotifierProvider(create: (ctx) => CarttManager()),
          ChangeNotifierProvider(create: (ctx) => OrdersManager())
        ],
        child: Consumer<AuthManager>(
          builder: (context, authmanager, child) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: authmanager.isAuth
                  ? const ProductOverviewScreen()
                  : FutureBuilder(
                      future: authmanager.tryAutoLogin(),
                      builder: (ctx, snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? const SplashScreen()
                            : const AuthScreen();
                      },
                    ),
              routes: {
                CartScreen.routeName: (ctx) => const CartScreen(),
                OrdersScreen2.routeName: (ctx) => const OrdersScreen2(),
                UserProductsScreen.routeName: (ctx) =>
                    const UserProductsScreen(),
              },
              onGenerateRoute: (settings) {
                if (settings.name == DetailProduct.routeName) {
                  final productId = settings.arguments as String;
                  return MaterialPageRoute(
                    builder: (ctx) {
                      return DetailProduct(
                          ctx.read<ProductManager>().findById(productId));
                    },
                  );
                }
                if (settings.name == EditProduct.routeName) {
                  final productId = settings.arguments as String?;
                  return MaterialPageRoute(builder: (ctx) {
                    return EditProduct(
                      productId != null
                          ? ctx.read<ProductManager>().findById(productId)
                          : null,
                    );
                  });
                }
                if (settings.name == DetailProduct.routeName) {
                  final matchId = settings.arguments as String;
                  return MaterialPageRoute(
                    builder: (ctx) {
                      return DetailProduct(
                        ctx.read<ProductManager>().findById(matchId),
                      );
                    },
                  );
                }
                return null;
              },
            );
          },
        ));
  }
}
