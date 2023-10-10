import 'dart:convert';
import 'dart:developer';
// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../models/books.dart';

class BookProvider extends ChangeNotifier {
  BookProvider(this.userId, this._allBooks);
  final String userId;
  List<Books> _allBooks = [];

  // BookProvider(this.userId, this._allBooks);

  List<Books> get book {
    return [..._allBooks];
  }

  Future<void> loadAllBooks() async {
    try {
      final url = Uri.parse(
          'https://appbook-1e0d2-default-rtdb.firebaseio.com/books.json');
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as List<dynamic>;
      final List<Books> loadedBooks = [];
      for (var book in extractedData) {
        final books = Books(
          id: book['bookId'],
          title: book['title'],
          author: book['author'],
          isPaid: book['isPaid'],
          content: book['link'],
          synopsis: book['synopsis'],
          imageUrl: book['imageUrl'],
        );

        loadedBooks.add(books);
      }

      _allBooks = loadedBooks;
    } catch (error) {
      print(error);
    }
  }

  Books findById(String id) {
    return _allBooks.firstWhere((book) => book.id == id);
  }

  List<Books> get showFreeBooks {
    return _allBooks.where((book) => book.isPaid == false).toList();
  }

  List<Books> get showPaidBooks {
    return _allBooks.where((book) => book.isPaid == true).toList();
  }

  List<Books> get shpwFavoriteBooks {
    return _allBooks.where((book) => book.isFavorite == true).toList();
  }
}
