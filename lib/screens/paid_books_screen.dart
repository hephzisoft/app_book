import 'package:app_book/widgets/book_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../config/colors.dart';
import '../models/books.dart';
import '../models/providers/book_providers.dart';

class PaidBooks extends StatefulWidget {
  const PaidBooks({
    super.key,
  });

  @override
  State<PaidBooks> createState() => _PaidBooksState();
}

class _PaidBooksState extends State<PaidBooks> {
  Future<void> _refreshBooks(BuildContext context) async {
    await Provider.of<BookProvider>(context, listen: false).loadAllBooks();
  }

  bool _isLoading = false;
  @override
  void initState() {
    _isLoading = true;

    Provider.of<BookProvider>(context, listen: false).loadAllBooks().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  String _searchQuery = '';
  List<Books> _filteredBooks = [];
  void _filterBooks() {
    final bookProvider = Provider.of<BookProvider>(context, listen: false);
    _filteredBooks = _searchQuery.isEmpty
        ? bookProvider.showPaidBooks
        : bookProvider.showPaidBooks
            .where((book) =>
                book.title.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    _filterBooks();

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: size * 0.25,
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
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                    _filterBooks();
                  });
                },
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
                  child: _isLoading
                      ? const Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : RefreshIndicator(
                          onRefresh: () => _refreshBooks(context),
                          child: GridView.builder(
                            itemCount: _filteredBooks.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 5 / 7,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 40,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return BookImage(
                                url: _filteredBooks[index].imageUrl,
                                id: _filteredBooks[index].id,
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
