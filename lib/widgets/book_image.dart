import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/books.dart';
import '../screens/book_details_screen.dart';

class BookImage extends StatelessWidget {
  const BookImage({
    super.key,
    required this.url,
    required this.id,
  });
  final String url;
  final String id;

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<Books>(context);
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(BookDetailsScreen.routeName,
              arguments: {'id': id, 'provider': bookProvider});
        },
        child: Image.network(
          url,
          // fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
