import 'package:flutter/material.dart';

import '../books.dart';

class BookProvider extends ChangeNotifier{

   final List<Books> _allBooks = const[
    Books(
      id: 'b1',
      title: 'The Alchemist',
      author: 'Paulo Coelho',
      isPaid: false,
      content: 'https://www.gutenberg.org/ebooks/2680',
      synposis:
      'A young shepherd boy named Santiago sets out from his homeland in Spain in search of treasure buried near the Pyramids of Egypt. Along the way, he meets a Gypsy woman, a king, and an alchemist, all of whom help him on his journey.',
      imageUrl:
      'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg',
    ),
    Books(
      id: 'b2',
      title: 'To Kill a Mockingbird',
      author: 'Harper Lee',
      isPaid: true,
      content: 'https://www.gutenberg.org/ebooks/2680',
      synposis:
      'A coming-of-age story set in the American South during the Great Depression, following a young girl named Scout as she witnesses the trial of a black man accused of raping a white woman.',
      imageUrl:
      'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg',
    ),
    Books(
      id: 'b3',
      title: '1984',
      author: 'George Orwell',
      isPaid: false,
      content: 'https://www.gutenberg.org/ebooks/2680',
      synposis:
      'A dystopian novel set in a future where the government controls every aspect of people\'s lives. The protagonist, Winston Smith, works for the Thought Police and is tasked with suppressing any dissent.',
      imageUrl:
      'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg',
    ),
    Books(
      id: 'b4',
      title: 'The Lord of the Rings',
      author: 'J.R.R. Tolkien',
      isPaid: true,
      content: 'https://www.gutenberg.org/ebooks/2680',
      synposis:
      'A fantasy novel following the hobbit Frodo Baggins as he embarks on a quest to destroy the One Ring, an evil artifact created by the Dark Lord Sauron.',
      imageUrl:
      'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg',
    ),
    Books(
      id: 'b5',
      title: 'The Hitchhiker\'s Guide to the Galaxy',
      author: 'Douglas Adams',
      isPaid: false,
      content: 'https://www.gutenberg.org/ebooks/2680',
      synposis:
      'A comedic science fiction novel following the adventures of Arthur Dent, a hapless Englishman who escapes Earth\'s destruction with his friend Ford Prefect, who turns out to be an alien researcher who was stranded on Earth for fifteen years while gathering information for the titular Hitchhiker\'s Guide to the Galaxy.',
      imageUrl:
      'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg',
    ),
    Books(
      id: 'b6',
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      isPaid: true,
      content: 'https://www.gutenberg.org/ebooks/2680',
      synposis:
      'A romance novel set in England during the Regency era, following the Bennet sisters as they navigate the complicated world of courtship and marriage.',
      imageUrl:
      'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg',
    ),
    Books(
      id: 'b7',
      title: 'Animal Farm',
      author: 'George Orwell',
      isPaid: false,
      content: 'https://www.gutenberg.org/ebooks/2680',
      synposis:
      'A satirical allegory of the Russian Revolution, following the animals of Manor Farm as they overthrow their human masters and establish a society where all animals are equal.',
      imageUrl:
      'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg',
    ),
    Books(
      id: 'b8',
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      isPaid: true,
      content: 'https://www.gutenberg.org/ebooks/2680',
      synposis:
      'A story of the American Dream gone wrong, following the wealthy Jay Gatsby as he pursues his love for Daisy Buchanan.',
      imageUrl:
      'https://www.gutenberg.org/cache/epub/2680/pg2680.cover.medium.jpg',
    ),
  ];
   List<Books> get book{
   return [..._allBooks];
 }

   List<Books> get showFreeBooks{
     return _allBooks.where((book) => book.isPaid==false).toList();
 }

   List<Books> get showPaidBooks{
     return _allBooks.where((book) => book.isPaid==true).toList();
   }


   Books  bookDetails(String id){
     return _allBooks.firstWhere((books){
       return books.id==id;
     });
   }

  // Future<void> getBooks() async{
  //   return ;
  // }
}