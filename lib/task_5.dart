import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class Task_5 extends StatefulWidget {
  @override
  _Task_5State createState() => _Task_5State();
}

class _Task_5State extends State<Task_5> {
  List<Photo>? photos;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        photos = responseData.map((json) => Photo.fromJson(json)).toList();
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task 5'),
      ),
      body: photos == null
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: photos!.length,
        itemBuilder: (context, index) {
          final photo = photos![index];
          return ListTile(
            title: Text(photo.title),
            leading: Image.network(photo.thumbnailUrl),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoDetailPage(photo: photo),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Photo {
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}

class PhotoDetailPage extends StatelessWidget {
  final Photo photo;

  const PhotoDetailPage({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(photo.title),
      ),
      body: Center(
        child: Image.network(photo.url),
      ),
    );
  }
}
