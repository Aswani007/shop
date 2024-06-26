import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';
import '../widgets/cart_item.dart' as ci;
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart =
        Provider.of<Cart>(context); // this gives me the access to the cart
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15.0),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'TOTAL',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(
                  //   width: 10.0,
                  // ),
                  Spacer(),
                  Chip(
                    label: Text('\₹${cart.totalAmount.toStringAsFixed(2)}'),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: cart),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, i) => ci.CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      //if there is the totalamount is zero then the button will be automatically disabled
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading ) ? null : () async {
        setState(() {
          _isLoading =  true;
        });
        await Provider.of<Orders>(context, listen: false).addOrder(
          widget.cart.items.values.toList(),
          widget.cart.totalAmount,
        );
        setState(() {
          _isLoading =  false;
        });
        widget.cart.clear();
      },
      child: _isLoading ? CircularProgressIndicator() : Text('Order Now'),
      color: Colors.green,
    );
  }
}
