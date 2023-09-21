import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/bloc/news_event.dart';
import 'package:news_app/bloc/news_state.dart';
import 'package:news_app/screens/tap_page.dart';
import 'package:news_app/utils/enum.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<NewsBloc>().add(
      GetNewsEvent(
        onError: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                "Internet bilan bog'lanishdagi xatolik",
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
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
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png"),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "News",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          var data = state.list;
          print(state.actionStatus);
          if (state.actionStatus == ActionStatus.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.actionStatus == ActionStatus.isSuccess) {
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
            );
          } else {
            return Center(
              child: Text("Server Error"),
            );
          }
        },
      ),
    );
  }
}
