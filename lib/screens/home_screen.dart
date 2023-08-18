import 'package:app_book/widgets/book_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

import '../config/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                  hintText: 'Search Free Books',
                  constraints: const BoxConstraints(minHeight: 50, maxWidth: 400),
                ),
              ),
            ),
            const SizedBox(
              height:10,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Free Books', style: Theme.of(context).textTheme.titleMedium,),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        BookImage(url:'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg'),
                        BookImage(url:'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg'),
                        BookImage(url:'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg'),
                        BookImage(url:'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg'),
                        BookImage(url:'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg'),
                        BookImage(url:'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg'),

                      ],
                    ),
                  ), const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        BookImage(url:'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg'),
                        BookImage(url:'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg'),
                        BookImage(url:'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg'),
                        BookImage(url:'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg'),
                        BookImage(url:'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg'),
                        BookImage(url:'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg'),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
