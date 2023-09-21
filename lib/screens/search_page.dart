import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/bloc/news_event.dart';
import 'package:news_app/bloc/news_state.dart';

import 'package:news_app/screens/tap_page.dart';
import 'package:news_app/utils/enum.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();

    context.read<NewsBloc>().add(
          SearchNews(
            text: _searchController.text.toString(),
            onError: (message) {
              return Center(
                child: Text("Not Found"),
              );
            },
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Form(
            child: TextFormField(
              onChanged: (e) {
                context.read<NewsBloc>().add(SearchNews(
                    text: _searchController.text.toString(),
                    onError: (message) {
                      return Center(
                        child: Text("Not Found"),
                      );
                    }));
              },
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => _searchController.clear(),
                ),
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state.actionStatus == ActionStatus.isLoading) {
              Center(
                child: Text("Qidirish uchun ma'lumot kiriting"),
              );
            } else if (state.actionStatus == ActionStatus.isSuccess) {
              var data = state.searchList;
              return Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TapPage(index: index),
                                  ));
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    bottom: 40,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          height: 150,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.9),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "${data[index].urlToImage}"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${data[index].title}",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                data[index]
                                                        .author
                                                        .toString()
                                                        .split("http")
                                                        .first
                                                        .isEmpty
                                                    ? "By ${data[index].author.toString().split("http").first}"
                                                    : "Undefind",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                data[index]
                                                    .publishedAt
                                                    .toString()
                                                    .replaceAll("T", " ")
                                                    .replaceAll("Z", " "),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
