import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';

class CNBCDetailPage extends StatefulWidget {
  final String title;
  final String link;
  final String description;

  const CNBCDetailPage({
    super.key,
    required this.title,
    required this.link,
    required this.description,
  });

  @override
  State<CNBCDetailPage> createState() => _CNBCDetailPageState();
}

class _CNBCDetailPageState extends State<CNBCDetailPage> {
  // List<Map<String, dynamic>> news = [];

  // Future<List<Map<String, dynamic>>> fetchCNBCNews() async {
  //   final response =
  //       await http.get(Uri.parse('https://www.cnbc.com/rss-feeds/'));
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> data = json.decode(response.body);
  //     final List<Map<String, dynamic>> items = data['items'];
  //     return items;
  //   } else {
  //     throw Exception('Failed to load CNBC news');
  //   }
  // }
  List topStories = [];

  Future fetchCNBCNews() async {
    final response = await http.get(Uri.parse(
        'https://search.cnbc.com/rs/search/combinedcms/view.xml?partnerId=wrss01&id=100003114'));
    // if (response.statusCode == 200) {
    //   final Xml2Json xml2json = Xml2Json();
    //   xml2json.parse(response.body.toString());
    //   final String jsonString = xml2json.toParker();
    //   final Map<String, dynamic> data = json.decode(jsonString);
    //   final List<Map<String, dynamic>> items = data['rss']['channel']['item'];
    //   return items;
    // } else {
    //   throw Exception('Failed to load CNBC news');
    // }

    final Xml2Json xml2json = Xml2Json();
    xml2json.parse(response.body.toString());

    var jsonData = await xml2json.toGData();
    var data = json.decode(jsonData);

    topStories = data['rss']['channel']['item'];

    // print(topStories);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchCNBCNews();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.substring(0, 18) + "..."),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image.network(
              //   widget.link,
              //   fit: BoxFit.cover,
              //   // width: 80,
              //   // height: 80,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                '(${widget.link})',
                style: TextStyle(
                    fontSize: 22,
                    // fontWeight: FontWeight.w400,
                    color: Colors.blueAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
