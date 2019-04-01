import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class BookContent extends StatefulWidget{
  final String title;

  BookContent(this.title);

  @override
  State<StatefulWidget> createState() {
    return BookContentState();
  }
}

class BookContentState extends State<BookContent>{
  Future<List<String>> _getBookChapters() async{
    String data = await rootBundle.loadString("assets/bible-books/${widget.title.replaceAll(' ', '').toLowerCase()}.json");
    final jsonResult = json.decode(data);

    List<String> chapters = [];
    for (var chapter in jsonResult){
      chapters.add(chapter);
    }

    return chapters;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getBookChapters(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData) return Container(child: Center(child: Text('Loading....')));
        
        return new ListView(
          padding: EdgeInsets.all(16),
          children: snapshot.data.map<Widget>((chapter) => 
            Column(
              children: <Widget>[
                // Text(index, style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
                // SizedBox(height: 20),
                Text(chapter, style: TextStyle(fontSize: 18, height: 1.5),),
                SizedBox(height: 80),
              ],
            )
          ).toList(),
        );

        // return Column(children: <Widget>[
        //   snapshot.data.map<Widget>((chapter) => 
            
        //   ).toList()
        // ]);
      },
    );
  }
}