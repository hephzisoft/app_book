import 'package:flutter/material.dart';

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
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(BookDetailsScreen.routeName, arguments: id);
        },
        child: Image.network(
          url,
          // fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
