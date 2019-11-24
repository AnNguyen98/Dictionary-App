import 'package:dictionary_app/word.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FrontFlashCard extends StatefulWidget {
  final Word word;
  FrontFlashCard({this.word});
  @override
  _FrontFlashCardState createState() => _FrontFlashCardState();
}

class _FrontFlashCardState extends State<FrontFlashCard> {
  bool isPlay = false;
  FlutterTts flutterTts = new FlutterTts();
  Future _speak(String str) async {
    setState(() async {
      isPlay = true;
      await flutterTts.speak(str);
      flutterTts.setCompletionHandler(() {
        isPlay = false;
      });
    });
  }

  Future _stop() async {
    setState(() {
      isPlay = false;
    });
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.greenAccent,
      ),
      padding: EdgeInsets.all(15),
      child: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Html(
                data: widget.word.content,
              )
            ],
          ),
          Row(
            children: <Widget>[
              Spacer(),
              Container(
                padding: EdgeInsets.all(5),
                child: GestureDetector(
                  onTapDown: (tap) {
                    isPlay ? _stop() : _speak(widget.word.word);
                  },
                  child: Icon(
                    Icons.volume_up,
                    size: 25,
                    color: isPlay ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
