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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Buddy Bible', 
          style: TextStyle(color: Colors.black),
        ),
        bottom: PreferredSize(
          child: Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Text(
              'Your daily bible assistant', 
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
          preferredSize: null,
        ),
        elevation: 0.4,
        backgroundColor: Colors.white
      ),
      backgroundColor: Colors.white,
      body: BookList(context)
    );
  }
}