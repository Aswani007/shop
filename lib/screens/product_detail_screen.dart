import 'package:flutter/material.dart';
import 'package:shopping_app/providers/cart.dart';
import 'package:shopping_app/providers/products.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../screens/cart_screen.dart';
class ProductDetailScreen extends StatelessWidget {
  // final String title;
  //
  // ProductDetailScreen(this.title);

  static const routeName = '/product_detail';

  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; //is the id
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);


    final cart = Provider.of<Cart>(context,
        listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        //so that our page is scrollable if space is not sufficient--SingleChildScrollView
        child: Column(
          children: <Widget>[
            Container(
              height: 400.0,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),

            Text(
                "Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                  fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 7.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0,),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
                style:TextStyle(color: Colors.black38,fontSize: 18,),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Price :",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 17.0,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),

                Text(
                  "\₹${loadedProduct.price}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red[300],
                    fontSize: 28.0,
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 20.0,
            ),
            MaterialButton(
              minWidth: 250,
              height: 60,
              color:Color(0xFF5E544B),
              onPressed: () {
                cart.additem(loadedProduct.id, loadedProduct.price, loadedProduct.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Color(0xE0413F42),
                    content: Text(
                      'added to the cart',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeSingleItem(loadedProduct.id);
                      },
                    ),
                  ),
                );

              },



              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),

              ),
              child: Text(
                "Add To Cart", style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,

              ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
