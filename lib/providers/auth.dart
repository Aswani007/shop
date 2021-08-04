import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signup(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=AIzaSyBfHFyIW6X7IhWO7AYXrhVG6_qOdW3lrUg');
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    print(json.decode(response.body));
  }
}

//final url = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=AIzaSyBfHFyIW6X7IhWO7AYXrhVG6_qOdW3lrUg'
// final url = Uri.https('https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=AIzaSyBfHFyIW6X7IhWO7AYXrhVG6_qOdW3lrUg');