import 'package:flutter/material.dart';
import './book-list.dart';

void main() => runApp(BuddyBible());

class BuddyBible extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buddy Bible',
      home: Home()
    );
  }
}

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BookList();
  }
}