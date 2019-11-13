class Article {
  String title;
  String imageUrl;
  String description;
  String content;
  String publishedAt;
  String author;

  Article({Map<String, dynamic> map}) {
    this.imageUrl = map['urlToImage'];
    this.title = map['title'];
    this.author = map['source']['name'];
    this.content = map['content'];
    this.description = map['description'];
    this.publishedAt = map['publishedAt'];
  }

}

class FullMap {
  int results;
  String status;
  List<dynamic> articlesList;

  FullMap(Map<String, dynamic> completeMap) {
    this.results = completeMap['totalResults'];
    this.status = completeMap['status'];
    this.articlesList = completeMap['articles'];
  }
}
