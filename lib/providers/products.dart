//adding mixin
// mixin is bit like extending another class and adding or merging some properties with the existing class
import 'package:flutter/cupertino.dart';
import 'package:shopping_app/models/http_exception.dart';
import '../providers/product.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; //prefix
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'KANIK',
    //   description: 'A ganjeri ladka',
    //   price: 29,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2014/04/03/10/31/boy-310726_960_720.png',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'AYUSH',
    //   description: 'Mummy se baat krni padegi ki bahu mil gayi hai',
    //   price: 59,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2014/04/02/10/36/man-303971_960_720.png',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'ASWANI',
    //   description: 'A GOOD BOY',
    //   price: 19,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/12/06/09/31/blank-1886008_960_720.png',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'JASLEEN',
    //   description: 'Gadhi',
    //   price: 49,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2018/04/04/12/28/elephant-3289662_960_720.png',
    // ),
  ];
  //var _showFavoritesOnly = false;

  final String authToken;

  Products(this.authToken,this._items);

  List<Product> get items {
    // if(_showFavoritesOnly){
    //   return _items.where((prodItem)=>prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere(
      (prod) => prod.id == id,
    );
  }

  //this controls what should be displayed
  // void showFavoritesOnly(){
  //   _showFavoritesOnly = true;
  //   notifyListeners(); // to rebuild the part we are interested in
  // }
  //
  // void showAll(){
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.https(
        'flutter-update-b10f3-default-rtdb.firebaseio.com', '/products.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = []; //creating an empty list
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(
          Product(
            //id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite'],
            imageUrl: prodData['imageUrl'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
      // print(json.decode(response.body));
    } catch (error) {
      print(error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.https(
        'flutter-update-b10f3-default-rtdb.firebaseio.com', '/products.json?auth=$authToken');
    try {
      final response =
          await http //wait for this to finish so that it can go to other code
              //await and async already comes with then and catcherror so we donot have to rap it in another
              .post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
          //then will execute only when this post is done, it is just like Onpressed
        }),
      );
      final newProduct = Product(
        // id: DateTime.now().toString(),
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      //_items.insert(index, element)
      notifyListeners();
    } catch (error) {
      print(error);
    }
    // .then((response) {
    //print(json.decode(response.body)); ---- this will give us the id of our item
    //this newProduct will execute only once the upper code is executed, this will wait for the upper part to finish executing

    // ).catchError((error) { // by this the app will not crash instead it will be telling flutter that the error is being handled
    //   print(error);
    //   throw error;
    // }
  }

//now updating data on the server
  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = Uri.https('flutter-update-b10f3-default-rtdb.firebaseio.com',
          '/products/$id.json?auth=$authToken');
      //patch will send a request to the server to merger the incoming to the existing data
      await http.patch(url,
          body: json.encode({
            //'key': value
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

//deleting form the server also
  Future<void> deleteProduct(String id) async {
    final url = Uri.https('flutter-update-b10f3-default-rtdb.firebaseio.com',
        '/products/$id.json?auth=$authToken');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    final response = await http.delete(url);
    _items.removeAt(existingProductIndex);
    notifyListeners();
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete Product.');
    }
    existingProduct = null;
  }
}
