class NewsItem {
  final String text;
  final String image;

  NewsItem({required this.text, required this.image});

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      text: json['text'],
      image: json['image'],
    );
  }
}