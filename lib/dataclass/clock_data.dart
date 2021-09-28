class Clock {
  final List<Word> words;
  Clock(this.words);
}

class Word {
  final int id;
  final String name;
  final String url;
  final String description;
  final String price;
  Word(this.id, this.name, this.url, this.description, this.price);
}
