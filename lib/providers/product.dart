import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue){
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus =
        isFavorite; // before making any changes we store the old status
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.https('flutter-update-b10f3-default-rtdb.firebaseio.com',
        '/products/$id.json');
    try {
     final response =  await http.patch(
        url,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
     if(response.statusCode >= 400){
       _setFavValue(oldStatus);
     }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
