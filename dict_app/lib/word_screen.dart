import 'package:dictionary_app/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_tts/flutter_tts.dart';

class WordScreen extends StatefulWidget {
  final Word word;
  WordScreen({this.word});
  @override
  _WordScreenState createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  bool isPlay = false;
  FlutterTts flutterTts = new FlutterTts();
  @override
  void initState() {
    super.initState();
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.word.word),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Stack(
          children: <Widget>[
            Html(
              data: widget.word.content,
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
