import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/colors.dart';
import '../models/providers/book_providers.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  static const routeName = '/book-details';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    final bookDetails =
        Provider.of<BookProvider>(context).bookDetails(id.toString());
    return Scaffold(
      body: LayoutBuilder(builder: (ctx, constraints) {
        return Column(children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            height: constraints.maxHeight * 0.4,
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
            child: Image.network(
              bookDetails.imageUrl,
              height: 250,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
            height: constraints.maxHeight * 0.4,
            child: Column(
              children: [
                Text(
                  bookDetails.author,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  bookDetails.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  bookDetails.synopsis,
                  softWrap: true,
                  style: GoogleFonts.lora(
                    fontSize: 18,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.1,
            width: double.infinity,
            child: Center(
              child: Row(
                children: [
                  Text(bookDetails.isPaid ? 'Paid Book' : 'Free Book'),
                  FilledButton(
                    onPressed: () async {
                      final Uri _url = Uri.parse(bookDetails.content);
                      if (!await launchUrl(_url)) {
                        throw Exception('Could not launch $_url');
                      }
                    },
                    style: OutlinedButton.styleFrom(),
                    child: const Text("Read More"),
                  ),
                ],
              ),
            ),
          ),
        ]);
      }),
    );
  }
}
