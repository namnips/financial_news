import 'package:financial_rss_app/pages/news/ndtv_page.dart';
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/news/cnbc_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial RSS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const HomePage(title: 'Home Page'),
      routes: {
        '/': (context) => HomePage(),
        '/cnbc': (context) => CNBCPage(),
        '/ndtv': (context) => NDTVPage(),
      },
    );
  }
}
