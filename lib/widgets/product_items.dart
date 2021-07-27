import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart.dart';
import 'package:shopping_app/providers/product.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // //final double price;
  //
  // ProductItem(this.id, this.title, this.imageUrl); //, this.price

  @override
  Widget build(BuildContext context) {
    //ClipRReact will force the child widget to warp it in certain shape

    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context,
        listen: false); //making it false so that it doesn't rebuild
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover, // to use the space available
          ),
        ),
        //header: GridTileBar(title: Text(price.toString()),), ---- this will add the price at the top
        footer: GridTileBar(
          //footer will add bar at the bottom
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              // leading for first and title for middle and trailing for last
              onPressed: () {
                product.toggleFavoriteStatus();
              },
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
          ),
          backgroundColor: Color(0xDB5E544B), //opacity color
          title: Text(
            //text in middle
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            // last icon
            onPressed: () {
              cart.additem(product.id, product.price, product.title);
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
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
