import 'package:flutter/material.dart';

class BookImage extends StatelessWidget {
  const BookImage({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: 250,
        width: 125,
        child: Image.network(url, fit: BoxFit.contain,),);
  }
}
