class Word {
  int id;
  String word;
  String content;
  bool isFavorite = false;
  Word({this.id, this.word, this.content});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'content': content,
    };
  }
}
