

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart.dart';
import 'package:shopping_app/providers/products.dart';
import '../screens/products_overview_screen.dart';
import '../screens/product_detail_screen.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../providers/orders.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import 'signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() => runApp(MyApp());
class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}
var token;
class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    getLocalData();
    super.initState();
  }


  getLocalData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token=prefs.getString('token');
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
          //for efficiency and to avoid bugs create method is used
          //in older version its is builder instead of create]
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context)=> Orders(),
        )
      ],
      child: MaterialApp(
        //only the child widget wil get rebuild
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor:
          Color(0xFFD6D2C4), // cream color for the background
          primaryColor: Color(0xFF5E544B), //appbar color brown
        ),
        home:token!=null?ProductsOverViewScreen():SignupPage(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName:(context)=> OrdersScreen(),
          UserProductsScreen.routeName:(context)=> UserProductsScreen(),
          EditProductScreen.routeName:(context) => EditProductScreen(),
        },
      ),
    );
  }
}


