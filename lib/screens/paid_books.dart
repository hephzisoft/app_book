import 'package:app_book/widgets/book_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../config/colors.dart';
import '../models/providers/book_providers.dart';

class PaidBooks extends StatelessWidget {
  const PaidBooks({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    final freeBooks = Provider.of<BookProvider>(context).showPaidBooks;
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: size * 0.35,
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: Center(
              child: SearchBar(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                leading: const Icon(IconlyLight.search),
                hintStyle: MaterialStateProperty.all(
                    GoogleFonts.poppins(fontSize: 18)),
                textStyle: MaterialStateProperty.all(
                    GoogleFonts.poppins(fontSize: 18)),
                hintText: 'Search Paid Books',
                constraints: const BoxConstraints(minHeight: 50, maxWidth: 400),
              ),
            ),
          ),
          SizedBox(
            height: size * 0.05,
          ),
          Container(
            height: size * 0.5,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Paid Books',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: freeBooks.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 5 / 7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 40,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return BookImage(url: freeBooks[index].imageUrl,id: freeBooks[index].id,);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
