import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Books with ChangeNotifier {
  final String id;
  final String title;
  final String author;
  final bool isPaid;
  final String content;
  final String synopsis;
  final String imageUrl;
  bool isFavorite;

  Books(
      {required this.id,
      required this.title,
      required this.author,
      required this.isPaid,
      required this.content,
      required this.synopsis,
      required this.imageUrl,
      this.isFavorite = false});

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final url = Uri.parse(
          'https://appbook-1e0d2-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json');
      final response = await http.put(
        url,
        body: json.encode(isFavorite),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
