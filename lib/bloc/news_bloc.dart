import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_event.dart';
import 'package:news_app/bloc/news_state.dart';
import 'package:news_app/services/news_service.dart';
import 'package:news_app/utils/enum.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  AppService service;

  NewsBloc(this.service)
      : super(NewsState(
          list: [],
          searchList: [],
          bookmarkedList: [],
        )) {
    on<ChangePage>((event, emit) {
      state.indexOfPage = event.pageIndex;

      emit(state.copyWith(indexOfPage: event.pageIndex));
    });
    on<GetNewsEvent>(
      (event, emit) async {
        emit(state.copyWith(status: ActionStatus.isLoading));

        final res = await service.getNews();

        if (res.isRight) {
          emit(
            state.copyWith(
              list: res.right,
              status: ActionStatus.isSuccess,
            ),
          );
        } else {
          event.onError(res.left);
          emit(state.copyWith(status: ActionStatus.isFailed));
        }
      },
    );
    on<SearchNews>(
      (event, emit) async {
        emit(state.copyWith(
          status: ActionStatus.isLoading,
        ));
        final res = await service.searchNews(text: event.text);
        if (res.isRight) {
          state.text = event.text;
          emit(state.copyWith(
            status: ActionStatus.isSuccess,
            searchList: res.right,
          ));
        } else {
          event.onError(res.left);
          emit(state.copyWith(status: ActionStatus.isFailed));
        }
      },
    );
    on<Bookmarked>((event, emit) async {
      if (state.indexOfPage == 0) {
        state.bookmarkedList.add(state.list[event.bookmarked_item!]);
      } else if (state.indexOfPage == 1) {
        state.bookmarkedList.add(state.searchList[event.bookmarked_item!]);
      }
      emit(state.copyWith(bookmarkedList: state.bookmarkedList));
    });
  }
}
