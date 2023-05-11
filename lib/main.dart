import 'package:flutter/material.dart';
import 'package:flutter_firebase_news_app/feature/home/home_view.dart';
import 'package:flutter_firebase_news_app/product/constants/string_contants.dart';
import 'package:flutter_firebase_news_app/product/initialize/app_theme.dart';
import 'package:flutter_firebase_news_app/product/initialize/application_start.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await ApplicationStart.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringContants.appName,
      home: const HomeView(),
      theme: AppTheme(context).theme,
    );
  }
}
