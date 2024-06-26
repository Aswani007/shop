
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/auth.dart';
import 'package:shopping_app/providers/cart.dart';
import 'package:shopping_app/providers/products.dart';
import '../screens/products_overview_screen.dart';
import '../screens/product_detail_screen.dart';
import '../providers/cart.dart';
import './providers/auth.dart';
import '../screens/cart_screen.dart';
import '../providers/orders.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth,Products>(
          //for efficiency and to avoid bugs create method is used
          //in older version its is builder instead of create]
          update: (context, auth, previousProducts) => Products(
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
          ),
          //create: (context) => Products(),

        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Orders(),
        )
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          //only the child widget wil get rebuild
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor:
                Color(0xFFD6D2C4), // cream color for the background
            primaryColor: Color(0xFF5E544B), //appbar color brown
          ),
          home: auth.isAuth ? ProductsOverViewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            UserProductsScreen.routeName: (context) => UserProductsScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
