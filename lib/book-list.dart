import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import './book.dart';

class BookList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return BookListState();
  }
}

class BookListState extends State<BookList>{
  Future<List<Book>> _getBooks() async{
    String data = await rootBundle.loadString("assets/books.json");
    final jsonResult = json.decode(data);

    List<Book> books = [];
    var idx = 0;
    for (var b in jsonResult){
      List<int> chapters = List<int>.from(b["chapters"]);
      String name = b["name"];
      String icon = "assets/bible-icons/${name.replaceAll(' ', '-')}-free-bible-icon.png".toLowerCase();
      Book book = Book(name, b["shortname"], icon, chapters);
      books.add(book);
      idx ++;

      if(idx == 15)
        break;
    }

    return books;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getBooks(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.data == null){
          return Container(
            child: Center(
              child: Text('Loading books....')
            )
          );
        }
        else
          return BooksGridView(books: snapshot.data);
      },
    );
  }
}

class BooksGridView extends StatelessWidget {
  final List<Book> books;

  BooksGridView({Key key, this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GridView.count(
      primary: true,
      crossAxisCount: 2,
      padding: EdgeInsets.all(12),
      shrinkWrap: true,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.92,
      scrollDirection: Axis.vertical,
      
      children: books.map((book) => BookItem(book)).toList(),
    );
  }
}

class BookItem extends StatelessWidget{
  final Book book;
  BookItem(this.book);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Image.asset(
              book.icon,
              width: 80, height: 80
            ),
            SizedBox(height: 10),
            Text(book.name, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20)),
            SizedBox(height: 4),
            Text(book.chapters.length.toString() + " Chapters", style: TextStyle(fontSize: 13, color: const Color(0xFF888888)))
          ]
        ),
      ),
      onPressed: () {},
    );
  }
}