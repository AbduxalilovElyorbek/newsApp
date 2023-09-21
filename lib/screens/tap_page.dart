import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/bloc/news_event.dart';
import 'package:news_app/bloc/news_state.dart';

class TapPage extends StatefulWidget {
  TapPage({super.key, required this.index});

  final int index;

  @override
  State<TapPage> createState() => _TapPageState();
}

class _TapPageState extends State<TapPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
      var data = state.indexOfPage == 0
          ? state.list[widget.index]
          : state.searchList[widget.index];
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<NewsBloc>().add(
                      Bookmarked(bookmarked_item: widget.index),
                    );
              },
              icon: Icon(
                Icons.bookmark_border_outlined,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.ios_share_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              child: Image.network(
                "${data.urlToImage}",
                height: 200,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Text(
                    data.title.toString(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://source.unsplash.com/random/?face",
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 12),
                              child: Text(
                                data.author
                                        .toString()
                                        .split("http")
                                        .first
                                        .isEmpty
                                    ? "By ${data.author.toString().split("http").first}"
                                    : "Undefind",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          data.publishedAt
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
                  Text(
                    data.content.toString(),
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
