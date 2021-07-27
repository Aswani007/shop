//adding mixin
// mixin is bit like extending another class and adding or merging some properties with the existing class
import 'package:flutter/cupertino.dart';
import '../providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'KANIK',
      description: 'A ganjeri ladka',
      price: 29,
      imageUrl:
          'https://cdn.pixabay.com/photo/2014/04/03/10/31/boy-310726_960_720.png',
    ),
    Product(
      id: 'p2',
      title: 'AYUSH',
      description: 'Mummy se baat krni padegi ki bahu mil gayi hai',
      price: 59,
      imageUrl:
          'https://cdn.pixabay.com/photo/2014/04/02/10/36/man-303971_960_720.png',
    ),
    Product(
      id: 'p3',
      title: 'ASWANI',
      description: 'A GOOD BOY',
      price: 19,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/12/06/09/31/blank-1886008_960_720.png',
    ),
    Product(
      id: 'p4',
      title: 'JASLEEN',
      description: 'Gadhi',
      price: 49,
      imageUrl:
          'https://cdn.pixabay.com/photo/2018/04/04/12/28/elephant-3289662_960_720.png',
    ),
  ];
  //var _showFavoritesOnly = false;

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

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );
    _items.add(newProduct);
    //_items.insert(index, element)

    notifyListeners();
  }
}
