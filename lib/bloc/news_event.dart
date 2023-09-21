class NewsEvent {}

class GetNewsEvent extends NewsEvent {
  final Function(String) onError;
  GetNewsEvent({
    required this.onError,
  });
}

class ChangePage extends NewsEvent {
  int pageIndex;
  ChangePage({required this.pageIndex});
}

class SearchNews extends NewsEvent {
  String text;

  final Function(String) onError;

  SearchNews({required this.text, required this.onError});
}

class Bookmarked extends NewsEvent {
  int? bookmarked_item;

  Bookmarked({
    this.bookmarked_item,
  });
}
