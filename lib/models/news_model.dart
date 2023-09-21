class NewsModel {
  String? title;

  String? author;
  String? content;
  String? urlToImage;
  String? publishedAt;

  NewsModel({
    this.title,
    this.author,
    this.content,
    this.urlToImage,
    this.publishedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        title: json['title'],
        content: json['content'],
        author: json['author'],
        urlToImage: json['urlToImage'],
        publishedAt: json['publishedAt'],
      );
}
