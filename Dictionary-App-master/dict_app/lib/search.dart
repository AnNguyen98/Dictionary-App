import 'package:dictionary_app/word.dart';
import 'package:flutter/material.dart';

class SearchShow extends StatefulWidget {
  final List<Word> list;
  SearchShow({this.list});
  @override
  _SearchShowState createState() => _SearchShowState();
}

class _SearchShowState extends State<SearchShow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          Word word = widget.list[index];
          return Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            child: Text(word.word),
          )
        },
      ),
    );
  }
}
