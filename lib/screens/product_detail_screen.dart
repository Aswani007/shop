import 'package:flutter/material.dart';
import 'package:shopping_app/providers/products.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

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
              '\₹${loadedProduct.price}',
              style: TextStyle(fontSize: 20.0, color: Colors.black38,fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0,),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
                style:TextStyle(color: Colors.black,fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
