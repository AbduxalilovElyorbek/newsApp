import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/bloc/news_bloc.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/services/news_service.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("bookmarked");
  runApp(
    BlocProvider(
      create: (context) => NewsBloc(AppService()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}
