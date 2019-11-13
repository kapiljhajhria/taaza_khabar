class Article {
  String sourceName;
  String title;
  String imageUrl;
  String description;
  String content;
  String publishedAt;
  String author;
  Article(this.sourceName, this.imageUrl, this.title, this.author, this.content,
      this.description, this.publishedAt);

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
