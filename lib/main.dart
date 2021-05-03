import 'package:flutter/material.dart';
import 'package:kliken/news_view/main_tab_bar.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "KLIKEN",
      theme: ThemeData(
        primaryIconTheme: IconThemeData(color: Colors.white),
        primaryColorBrightness: Brightness.light,
        colorScheme: ColorScheme.fromSwatch(),
        primarySwatch: Colors.orange,
      ),
      home: MainTabBar(),
    );
  }
}
