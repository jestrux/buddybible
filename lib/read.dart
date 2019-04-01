import 'package:flutter/material.dart';
import './book.dart';
import './book-content.dart';

class Read extends StatelessWidget{
  final Book book;

  Read(this.book);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.name, 
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        elevation: 0.4,
        backgroundColor: Colors.white
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: BookContent(book.name),
      ),
    );
  }
}