import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'cnbc_detail_page.dart';

class CNBCPage extends StatefulWidget {
  const CNBCPage({super.key});

  @override
  State<CNBCPage> createState() => _CNBCPageState();
}

class _CNBCPageState extends State<CNBCPage> {
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
        title: Text('CNBC News'),
      ),
      body: FutureBuilder(
        future: fetchCNBCNews(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Top Stories",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  controller: ScrollController(),
                  itemCount: topStories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            spreadRadius: 2,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                      child: ListTile(
                        horizontalTitleGap: 10,
                        minVerticalPadding: 10,
                        contentPadding: const EdgeInsets.all(8),
                        title: Text(
                          topStories[index]['title']['\$t'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CNBCDetailPage(
                                title: topStories[index]['title']['\$t'],
                                link: topStories[index]['link']['\$t'],
                                description: topStories[index]['description']
                                    ['__cdata'],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
