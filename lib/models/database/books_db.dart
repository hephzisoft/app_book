import 'package:sqflite/sqflite.dart';

import '../books.dart';
import 'books_database.dart';

class BookDB {
  final tableName = 'books';
  Future<void> createTable(Database database) async {
    await database.execute("""CREATE TABLE IF NOT EXISTS $tableName(
  "id" VARCHAR(255) PRIMARY KEY,
  "title"  VARCHAR(255) NOT NULL,
  "author" VARCHAR(255) NOT NULL,
  "isPaid" BOOLEAN NOT NULL,
  "content" TEXT NOT NULL; """);
  }

  Future<int> create({required String title}) async {
    final database = await DatabaseService().database;
    return await database
        .rawInsert('''INSERT INTO $tableName (title) VALUES (?)''', [title]);
  }

  Future<List<Books>> fetchAll() async {
    final database = await DatabaseService().database;
    final books = await database.rawQuery('''SELECT * from $tableName ''');
    return books.map((book) => Books.fromSqfliteDatabase(book)).toList();
  }


  Future<Books> fetchById(String id) async{
    
  }
}
