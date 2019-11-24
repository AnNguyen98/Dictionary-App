import 'package:dictionary_app/front_plash_card.dart';
import 'package:dictionary_app/word.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class WordScreen extends StatefulWidget {
  final Word word;
  WordScreen({this.word});
  @override
  _WordScreenState createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.word.word),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: FlipCard(
          direction: FlipDirection.HORIZONTAL, // default
          front: Container(
            child: FrontFlashCard(
              word: widget.word,
            ),
          ),

          back: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.greenAccent,
            ),
            padding: EdgeInsets.all(15),
            child: Center(
              child: Text(widget.word.word),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () {
          setState(() {
            widget.word.isFavorite = !widget.word.isFavorite;
          });
        },
        child: Icon(
          Icons.thumb_up,
          color: widget.word.isFavorite ? Colors.blue : Colors.white,
        ),
      ),
    );
  }
}
