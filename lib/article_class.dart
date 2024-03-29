class Article {
  String title;
  String imageUrl;
  String description;
  String content;
  String publishedAt;
  String author;
  String hoursAgo;
  String humanReadableTime;
  String fullNewsUrl;
  String date;
  String time;

  Article({
    String title,
    String imageUrl,
    String description,
    String content,
    String publishedAt,
    String author,
    String fullNewsUrl,
    String date,
    String time,
  }) {
    
    this.title = trimTitle(title);
    this.imageUrl = imageUrl;
    this.description = description;
    this.content = removeAuthorFromContent(content);
    this.publishedAt = publishedAt;
    this.author = author;
    this.hoursAgo =
        '${DateTime.now().difference(DateTime.parse(publishedAt)).inHours} hours ago';
    this.fullNewsUrl = fullNewsUrl;
    this.date = '${DateTime.parse(publishedAt).toLocal().day}-${DateTime.parse(publishedAt).toLocal().month}-${DateTime.parse(publishedAt).toLocal().year}';
    this.time = '${DateTime.parse(publishedAt).toLocal().hour}:${DateTime.parse(publishedAt).toLocal().minute} Hrs';
  }
}

String removeAuthorFromContent(String content) {
  List temp = content.split('[');

  return temp[0];
}

String trimTitle(String title) {
  List temp = title.split('-');
  return temp[0];
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
        fullNewsUrl: map['url'],
          author: map['source']['name'],
          content: map['content'] == null ? '' : map['content'],
          description: map['description'] == null ? '' : map['description'],
          imageUrl: map['urlToImage'] == null ? '' : map['urlToImage'],
          publishedAt: map['publishedAt'],
          title: map['title']));
    });
  }
}
