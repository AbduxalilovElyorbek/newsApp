import 'package:news_app/models/news_model.dart';
import 'package:news_app/utils/enum.dart';

class NewsState {
  List<NewsModel> list;
  int indexOfPage;
  ActionStatus actionStatus;
  String text;
  List<NewsModel> searchList;
  List<NewsModel> bookmarkedList;

  NewsState({
    required this.list,
    this.indexOfPage = 0,
    this.actionStatus = ActionStatus.isPure,
    this.text = "",
    required this.searchList,
    required this.bookmarkedList,
  });
  NewsState copyWith({
    List<NewsModel>? list,
    int? indexOfPage,
    ActionStatus? status,
    String? text,
    List<NewsModel>? searchList,
    List<NewsModel>? bookmarkedList,
  }) =>
      NewsState(
        list: list ?? this.list,
        indexOfPage: indexOfPage ?? this.indexOfPage,
        actionStatus: status ?? this.actionStatus,
        text: text ?? this.text,
        searchList: searchList ?? this.list,
        bookmarkedList: bookmarkedList ?? this.bookmarkedList,
      );
}
