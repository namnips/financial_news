import 'package:flutter/material.dart';

class NDTVDetailPage extends StatefulWidget {
  final String title;
  final String imagePath;
  final String description;

  const NDTVDetailPage({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
  });

  @override
  State<NDTVDetailPage> createState() => _NDTVDetailPageState();
}

class _NDTVDetailPageState extends State<NDTVDetailPage> {
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
              Image.network(
                widget.imagePath,
                fit: BoxFit.cover,
                // width: 80,
                // height: 80,
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
