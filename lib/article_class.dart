class Article {
  String sourceName;
  String title;
  String imageUrl;
  String description;
  String content;
  String publishedAt;
  String author;
  List<Map<String, dynamic>> getArticles(
      {Map<String, dynamic> mapFromJsonUrl}) {
    return mapFromJsonUrl['articles'];
  }

  Article.fromJsonMap(Map<String, dynamic> map) {
    author = map['source']['name'];
    title = map['title'];
    description = map['description'];
    imageUrl = map['urlToImage'];
    publishedAt = map['publishedAt'];
    content = map['content'];
  }
}
