import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import './book.dart';
import './read.dart';

class BookList extends StatefulWidget{
  final BuildContext ctx;

  BookList(this.ctx);

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
    for (var b in jsonResult){
      List<int> chapters = List<int>.from(b["chapters"]);
      String name = b["name"];
      String icon = "assets/bible-icons/${name.replaceAll(' ', '-')}-free-bible-icon.png".toLowerCase();
      Book book = Book(name, b["shortname"], icon, chapters);
      books.add(book);
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
          return BooksGridView(books: snapshot.data, ctx: widget.ctx);
      },
    );
  }
}

class BooksGridView extends StatelessWidget {
  final List<Book> books;
  final BuildContext ctx;

  BooksGridView({Key key, this.books, this.ctx}) : super(key: key);

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
      
      children: books.map((book) => BookItem(book:book, ctx: ctx)).toList(),
    );
  }
}

class BookItem extends StatelessWidget{
  final Book book;
  final BuildContext ctx;

  BookItem({this.book, this.ctx});

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
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Read(book)),
        );
      },
    );
  }
}