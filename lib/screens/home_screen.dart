import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/bloc/news_event.dart';
import 'package:news_app/bloc/news_state.dart';
import 'package:news_app/screens/home_page.dart';
import 'package:news_app/screens/save_page.dart';
import 'package:news_app/screens/search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        var data = context.read<NewsBloc>();
        return Scaffold(
          body: pages[state.indexOfPage],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (e) {
              data.add(ChangePage(pageIndex: e));
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: state.indexOfPage == 0 ? Colors.blue : Colors.grey,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                    color: state.indexOfPage == 1 ? Colors.blue : Colors.grey,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.bookmark_border_outlined,
                    color: state.indexOfPage == 2 ? Colors.blue : Colors.grey,
                  ),
                  label: ''),
            ],
          ),
        );
      },
    );
  }
}

List pages = [
  HomePage(),
  SearchPage(),
  SavePage(),
];
