import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/colors.dart';
import '../models/providers/book_providers.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  static const routeName = '/book-details';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
   final bookDetails =  Provider.of<BookProvider>(context).bookDetails(id.toString());
    return Scaffold(
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Column(children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            height: constraints.maxHeight * 0.35,
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: Image.network(bookDetails.imageUrl,height: 250,),
          ),
          Container(
            height: constraints.maxHeight * 0.4,
          ),
          Container(
            height: constraints.maxHeight * 0.2,
          ),
        ]);
      }),
    );
  }
}
