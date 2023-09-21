import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/bloc/news_state.dart';
import 'package:news_app/screens/tap_page.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<SavePage> createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Bookmarked",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            )),
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          var data = state.bookmarkedList;
          return Container(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                          "${data[index].urlToImage ?? "https://source.unsplash.com/random"}"),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
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
          );
        },
      ),
    );
  }
}
