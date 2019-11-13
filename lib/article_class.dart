class Article {
  String title;
  String imageUrl;
  String description;
  String content;
  String publishedAt;
  String author;

  Article(
      {this.publishedAt,
      this.description,
      this.content,
      this.author,
      this.title,
      this.imageUrl});
}

class FullMap {
  int results;
  String status;
  List<dynamic> articlesListOfMap;

  FullMap(Map<String, dynamic> mapReturnedFromJson) {
    this.results = mapReturnedFromJson['totalResults'];
    this.status = mapReturnedFromJson['status'];
    this.articlesListOfMap = mapReturnedFromJson['articles'];
  }
}

class ArticlesList {
  List<Article> allArticles = [];
  ArticlesList(List<dynamic> articleData) {
    articleData.forEach((map) {
      allArticles.add(Article(
          author: map['source']['name'],
          content: map['content'],
          description: map['description'],
          imageUrl: map['urlToImage'],
          publishedAt: map['publishedAt'],
          title: map['title']));
    });
  }
}
